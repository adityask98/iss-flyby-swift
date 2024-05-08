//
//  CalendarEventParser.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2024/02/18.
//

import AlertToast
import EventKit
import Foundation

struct CalendarEventParser {
  static func parseandCreateCalendarEvent(data: Item, date: String, time: String) {
    print("TIME STRING", time)
    print("DATE STRING", date)
    //let lines = data.components(separatedBy: "\n")

    var dateString = data.description.date
    var timeString = data.description.time

    let dateTimeString = "\(dateString) \(timeString)"
    print(dateTimeString)
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MMMM d, yyyy h:mm a"  // Adjust the date format to match your input
    formatter.locale = Locale(identifier: "en_US_POSIX")  // Use POSIX to ensure AM/PM is handled correctly
    guard let date = formatter.date(from: dateTimeString) else {
      print("Error parsing date")
      return
    }
    print("Parsed date: ")
    print(date)
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
    reminder.title = data.title

    reminder.notes = "This is a note"
    var tempDateComp = DateComponents()
    tempDateComp.year = calendar.component(.year, from: date)
    tempDateComp.month = calendar.component(.month, from: date)
    tempDateComp.day = calendar.component(.day, from: date)
    tempDateComp.hour = components.hour
    tempDateComp.minute = components.minute
    reminder.dueDateComponents = tempDateComp
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
