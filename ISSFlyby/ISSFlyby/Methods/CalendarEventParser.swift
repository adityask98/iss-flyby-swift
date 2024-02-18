//
//  CalendarEventParser.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2024/02/18.
//

import Foundation
import EventKit

struct CalendarEventParser {
    static func parseandCreateCalendarEvent(data: String) {
        let lines = data.components(separatedBy: "\n")
        
        var dateString: String?
        var timeString: String?
        
        for line in lines {
            let components = line.components(separatedBy: ": ")
            let key = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let value = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
            switch key {
            case "Date":
                dateString = value
            case "Time":
                timeString = value
            default:
                break
            }
        }
        guard let dateString = dateString, let timeString = timeString else {
            print("Error, failed to parse.")
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMM d, yyyy"
        guard let date = formatter.date(from: dateString) else {
            print("Error parsing date")
            return
        }
        
        formatter.dateFormat = "h:mm a"
        guard let time = formatter.date(from: timeString) else {
            print("Error parsing time")
            return
        }
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.hour = calendar.component(.hour, from: time)
        components.minute = calendar.component(.minute, from: time)
        
        let startDate = calendar.date(from: components)!
        
        let store = EKEventStore()
        let event = EKEvent(eventStore: store)
        event.title = "ISSFlyby"
        event.startDate = startDate
        event.endDate = startDate
        let reminder: EKReminder = EKReminder(eventStore: store)
        reminder.title = "ISSFlyBy"
        reminder.notes = "This is a note"
        reminder.calendar = store.defaultCalendarForNewReminders()
        do {
            try store.save(reminder, commit: true)
        } catch {
            print("Error saving reminder")
            return
        }
        print("Reminder saved successfully")
        return
        
    }
}
