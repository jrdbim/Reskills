import Foundation

// Formats a subtitle string based on mode (date or time)
func formattedSubtitle(for date: Date, mode: Mode) -> String {
    switch mode {
    case .date:
        let calendar = Calendar.current
        if calendar.isDateInToday(date) { return "Today" }
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter.string(from: date)
    case .time:
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// Rounds a date up to the next full hour (minutes/seconds -> 00, hour + 1 if needed)
func roundedUpToHour(_ date: Date) -> Date {
    let calendar = Calendar.current
    var comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    comps.hour = (comps.hour ?? 0) + 1
    comps.minute = 0
    comps.second = 0
    return calendar.date(from: comps) ?? date
}

// Combines a day (year/month/day) and a time (hour/minute/second) into a single Date
func combineDateTime(date dayDate: Date, time timeDate: Date, calendar: Calendar = .current) -> Date? {
    let dayComponents = calendar.dateComponents([.year, .month, .day], from: dayDate)
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: timeDate)

    var combined = DateComponents()
    combined.year = dayComponents.year
    combined.month = dayComponents.month
    combined.day = dayComponents.day
    combined.hour = timeComponents.hour
    combined.minute = timeComponents.minute
    combined.second = timeComponents.second ?? 0

    return calendar.date(from: combined)
}
