import WidgetKit
import SwiftUI
import Intents
import os.log

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
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        var nextClass: [String: Any]?
        var earliestStartTime: Date?
        
        logger.info("Searching through \(classes.count) classes")
        
        for cls in classes {
            guard let startTimeString = cls["start_time"] as? String,
                  !startTimeString.isEmpty else { 
                logger.debug("Skipping class with empty start time")
                continue 
            }
            
            guard let startTime = timeFormatter.date(from: startTimeString) else {
                logger.error("Failed to parse time: \(startTimeString)")
                continue
            }
            
            // Create date with today's date and class time
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: now)
            let timeComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            components.hour = timeComponents.hour
            components.minute = timeComponents.minute
            
            guard let classStartTime = calendar.date(from: components) else { continue }
            
            // Skip past classes
            if classStartTime <= now {
                logger.debug("Skipping past class: \(startTimeString)")
                continue
            }
            
            // Find the earliest upcoming class
            if earliestStartTime == nil || classStartTime < earliestStartTime! {
                earliestStartTime = classStartTime
                nextClass = cls
                logger.debug("Found new next class: \(cls["course_name"] as? String ?? "Unknown") at \(startTimeString)")
            }
        }
        
        return nextClass
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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if entry.courseName == "No Upcoming Class" || entry.courseName.contains("No") {
                Text("No Upcoming Class")
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text(entry.courseName)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                
                if !entry.faculty.isEmpty {
                    Text(entry.faculty)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                if !entry.venue.isEmpty {
                    Text(entry.venue)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                if !entry.timing.isEmpty {
                    Text(entry.timing)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
        .padding()
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
