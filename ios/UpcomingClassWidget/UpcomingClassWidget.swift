import WidgetKit
import SwiftUI
import Intents

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
        guard let sharedDefaults = UserDefaults(suiteName: "group.com.udhay.vitapstudentapp") else {
            return SimpleEntry(date: Date(), courseName: "No Data", faculty: "", venue: "", timing: "")
        }
        
        guard let timetableData = sharedDefaults.string(forKey: "timetable")?.data(using: .utf8),
              let timetable = try? JSONSerialization.jsonObject(with: timetableData) as? [String: Any] else {
            return SimpleEntry(date: Date(), courseName: "No Timetable", faculty: "", venue: "", timing: "")
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let currentDay = formatter.string(from: Date())
        
        guard let todayClasses = timetable[currentDay] as? [[String: Any]] else {
            return SimpleEntry(date: Date(), courseName: "No Classes", faculty: "", venue: "", timing: "")
        }
        
        let nextClass = findNextClass(classes: todayClasses)
        
        if let nextClass = nextClass {
            return SimpleEntry(
                date: Date(),
                courseName: nextClass["course_name"] as? String ?? "",
                faculty: nextClass["faculty"] as? String ?? "",
                venue: nextClass["venue"] as? String ?? "",
                timing: nextClass["time"] as? String ?? ""
            )
        } else {
            return SimpleEntry(date: Date(), courseName: "No Upcoming Class", faculty: "", venue: "", timing: "")
        }
    }
    
    private func findNextClass(classes: [[String: Any]]) -> [String: Any]? {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        var nextClass: [String: Any]?
        var smallestTimeDifference: TimeInterval = .greatestFiniteMagnitude
        
        for cls in classes {
            guard let timeRange = cls["time"] as? String else { continue }
            
            let parts = timeRange.components(separatedBy: " - ")
            guard parts.count >= 2,
                  let startTime = dateFormatter.date(from: parts[0]) else { continue }
            
            // Create date with today's date and class time
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: now)
            let timeComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            components.hour = timeComponents.hour
            components.minute = timeComponents.minute
            
            guard let classStart = calendar.date(from: components) else { continue }
            
            // Skip past classes
            guard classStart > now else { continue }
            
            // Find the closest upcoming class
            let timeDifference = classStart.timeIntervalSince(now)
            if timeDifference < smallestTimeDifference {
                smallestTimeDifference = timeDifference
                nextClass = cls
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
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.courseName)
                .font(.system(size: 16, weight: .semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            
            if entry.courseName != "No Upcoming Class" {
                InfoRow(icon: "person", text: entry.faculty)
                InfoRow(icon: "mappin", text: entry.venue)
                InfoRow(icon: "clock", text: entry.timing)
            }
            
            HStack {
                Spacer()
                Text("Updated: \(entry.date, style: .time)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.top, 4)
        }
        .padding(12)
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 20)
                .foregroundColor(.blue)
            Text(text)
                .font(.system(size: 14))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
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
        courseName: "Introduction to Machine Learning",
        faculty: "T RAMA THULASI",
        venue: "220-CB",
        timing: "11:00 - 11:50"
    )
}
