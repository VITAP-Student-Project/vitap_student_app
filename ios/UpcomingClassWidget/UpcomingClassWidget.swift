import WidgetKit
import SwiftUI
import Intents
import os.log
import AppIntents

// Refresh Intent for widget button
struct RefreshIntent: AppIntent {
    static var title: LocalizedStringResource = "Refresh Widget"
    static var description = IntentDescription("Refreshes the upcoming class widget")
    
    func perform() async throws -> some IntentResult {
        // Reload all timelines for this widget
        WidgetCenter.shared.reloadTimelines(ofKind: "UpcomingClassWidget")
        return .result()
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), courseName: "Loading...", faculty: "", venue: "", timing: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), courseName: "Database Management", faculty: "Prof. Bharathi", venue: "231-CB", timing: "15:00 - 15:50")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
        
        let entry = fetchNextClass()
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
    
    private func fetchNextClass() -> SimpleEntry {
        let logger = Logger(subsystem: "com.udhay.vitapstudentapp", category: "UpcomingClassWidget")
        
        guard let sharedDefaults = UserDefaults(suiteName: "group.com.udhay.vitapstudentapp") else {
            logger.error("Failed to access shared user defaults")
            return SimpleEntry(date: Date(), courseName: "No Data", faculty: "", venue: "", timing: "")
        }
        
        guard let timetableData = sharedDefaults.string(forKey: "timetable")?.data(using: .utf8),
              let timetable = try? JSONSerialization.jsonObject(with: timetableData) as? [String: Any] else {
            logger.error("Failed to parse timetable data")
            return SimpleEntry(date: Date(), courseName: "No Timetable", faculty: "", venue: "", timing: "")
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "en_US") // Ensure English day names to match JSON keys
        let currentDay = formatter.string(from: Date())
        logger.info("Checking classes for: \(currentDay)")
        
        guard let todayClasses = timetable[currentDay] as? [[String: Any]] else {
            logger.info("No classes found for \(currentDay)")
            return SimpleEntry(date: Date(), courseName: "No Classes Today", faculty: "", venue: "", timing: "")
        }
        
        let nextClass = findNextClass(classes: todayClasses)
        
        if let nextClass = nextClass {
            let startTime = nextClass["start_time"] as? String ?? ""
            let endTime = nextClass["end_time"] as? String ?? ""
            let timing = !startTime.isEmpty && !endTime.isEmpty ? "\(startTime) - \(endTime)" : ""
            
            logger.info("Found next class: \(nextClass["course_name"] as? String ?? "Unknown")")
            
            return SimpleEntry(
                date: Date(),
                courseName: nextClass["course_name"] as? String ?? "Unknown Course",
                faculty: nextClass["faculty"] as? String ?? "Unknown Faculty",
                venue: nextClass["venue"] as? String ?? "Unknown Venue",
                timing: timing
            )
        } else {
            logger.info("No upcoming classes found for today")
            return SimpleEntry(date: Date(), courseName: "No Upcoming Class", faculty: "", venue: "", timing: "")
        }
    }
    
    private func findNextClass(classes: [[String: Any]]) -> [String: Any]? {
        let logger = Logger(subsystem: "com.udhay.vitapstudentapp", category: "UpcomingClassWidget")
        let now = Date()
        let calendar = Calendar.current
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        var nextClass: [String: Any]?
        var earliestStartTime: Date?
        var currentClass: [String: Any]?
        
        logger.info("Searching through \(classes.count) classes")
        
        for cls in classes {
            guard let startTimeString = cls["start_time"] as? String,
                  let endTimeString = cls["end_time"] as? String,
                  !startTimeString.isEmpty else { 
                logger.debug("Skipping class with empty time")
                continue 
            }
            
            guard let startTime = timeFormatter.date(from: startTimeString),
                  let endTime = timeFormatter.date(from: endTimeString) else {
                logger.error("Failed to parse time: \(startTimeString)")
                continue
            }
            
            // Create date with today's date and class time
            var startComponents = calendar.dateComponents([.year, .month, .day], from: now)
            let startTimeComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            startComponents.hour = startTimeComponents.hour
            startComponents.minute = startTimeComponents.minute
            
            var endComponents = calendar.dateComponents([.year, .month, .day], from: now)
            let endTimeComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            endComponents.hour = endTimeComponents.hour
            endComponents.minute = endTimeComponents.minute
            
            guard let classStartTime = calendar.date(from: startComponents),
                  let _ = calendar.date(from: endComponents) else { continue }
            
            // Check if class is currently ongoing (within first 20 minutes)
            let twentyMinutesAfterStart = calendar.date(byAdding: .minute, value: 20, to: classStartTime)!
            
            if now >= classStartTime && now < twentyMinutesAfterStart {
                // Current class is still within first 20 minutes
                currentClass = cls
                logger.info("Found current class (within 20 min): \(cls["course_name"] as? String ?? "Unknown")")
                break
            } else if classStartTime > now {
                // Future class
                if earliestStartTime == nil || classStartTime < earliestStartTime! {
                    earliestStartTime = classStartTime
                    nextClass = cls
                    logger.debug("Found upcoming class: \(cls["course_name"] as? String ?? "Unknown") at \(startTimeString)")
                }
            }
        }
        
        // Return current class if found, otherwise return next class
        return currentClass ?? nextClass
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let courseName: String
    let faculty: String
    let venue: String
    let timing: String
}

struct UpcomingClassWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 4) {
                // Header with title and refresh button
                HStack {
                    Text("Next Class")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(intent: RefreshIntent()) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.primary)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.bottom, 4)
                
                if entry.courseName == "No Upcoming Class" || entry.courseName.contains("No") {
                    Spacer()
                    Text("No Upcoming Class")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    Spacer()
                } else {
                    // Course Name - Most prominent
                    Text(entry.courseName)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    // Timing - Second most important
                    if !entry.timing.isEmpty {
                        Text(entry.timing)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.top, 2)
                    }
                    
                    // Faculty - Supporting info
                    if !entry.faculty.isEmpty {
                        Text(entry.faculty)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 4)
                    }
                    
                    // Venue - Supporting info
                    if !entry.venue.isEmpty {
                        Text(entry.venue)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 2)
                    }
                    
                    Spacer()
                }
            }
            .padding(6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct UpcomingClassWidget: Widget {
    let kind: String = "UpcomingClassWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            UpcomingClassWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Next Class")
        .description("Shows your upcoming class")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    UpcomingClassWidget()
} timeline: {
    SimpleEntry(
        date: Date(),
        courseName: "Database Management",
        faculty: "Prof. Bharathi",
        venue: "231-CB",
        timing: "15:00 - 15:50"
    )
}
