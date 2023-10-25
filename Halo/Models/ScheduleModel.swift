//
//  ScheduleModel.swift
//  Halo
//
//  Created by Dante Kim on 10/21/23.
//

import Foundation

struct Schedule: Codable, Identifiable, Equatable {
    var id = UUID()
    var title: String
    var breaks: Bool
    var starts: Date
    var ends: Date
    var daysOfWeek: [Day]
    var isSuggested: Bool = false
    var description: String = ""
    var appsCount: Int = 0
    var categoriesCount: Int = 0
    var isOn: Bool = true
    
    var isActive: Bool {
        if isSuggested {
            return false
        } else {
            let calendar = Calendar.current
            // Extract hour and minute from starts and ends
            let startHour = calendar.component(.hour, from: starts)
            let startMinute = calendar.component(.minute, from: starts)
            let endHour = calendar.component(.hour, from: ends)
            let endMinute = calendar.component(.minute, from: ends)
            
            // Get the current hour and minute
            let currentHour = calendar.component(.hour, from: Date())
            let currentMinute = calendar.component(.minute, from: Date())
            
            // Check if the current time is between the start and end times
            let isAfterStartTime = currentHour > startHour || (currentHour == startHour && currentMinute >= startMinute)
            let isBeforeEndTime = currentHour < endHour || (currentHour == endHour && currentMinute <= endMinute)
            let isBetweenTimes = isAfterStartTime && isBeforeEndTime
            
            // Check if the current day of the week is in the selected days
            let currentWeekday = calendar.component(.weekday, from: Date())
            let currentDay = Day.allDays[currentWeekday - 1]
            let isDaySelected = daysOfWeek.contains(currentDay)
            return isBetweenTimes && isToday
        }
    }
    
    
    var isToday: Bool {
        let calendar = Calendar.current

        // Check if the current day of the week is in the selected days
        let currentWeekday = calendar.component(.weekday, from: Date())
        let currentDay = Day.allDays[currentWeekday - 1]
        let isDaySelected = daysOfWeek.contains(currentDay)
        return isDaySelected
    }
    
    var isAllDay: Bool {
        if ((starts == Calendar.current.date(from: DateComponents(hour: 0, minute: 0))! && ends == Calendar.current.date(from: DateComponents(hour: 23, minute: 59))!)) {
            return true
        }
        return false
    }
    
    static var suggestedSchedules = [Schedule(title: "🧘 Precious Mode",  breaks: true, starts:  Calendar.current.date(from: DateComponents(hour: 0, minute: 0))!, ends:  Calendar.current.date(from: DateComponents(hour: 23, minute: 59))!, daysOfWeek: [Day(name: "Su"),Day(name: "M"), Day(name: "T"), Day(name: "W"),Day(name: "Th"),Day(name: "F"), Day(name: "S")], isSuggested: true, description: "Block selected apps the entire day, you can still unlock with coins. At the end of the day you get a focus bonus 🎁")]
        
    static var savedSchedules = [Schedule]()
    static var templateSchedule = Schedule(title: "💎 My Schedule", breaks: true, starts:  Calendar.current.date(from: DateComponents(hour: 0, minute: 0))!, ends: Calendar.current.date(from: DateComponents(hour: 23, minute: 59))!, daysOfWeek: [Day(name: "Su"),Day(name: "M"), Day(name: "T"), Day(name: "W"),Day(name: "Th"),Day(name: "F"),Day(name: "S")], isSuggested: true, description: "", isOn: false)
    
    var dayFormatted: String {
        let weekDays =  Set([Day(name: "M"), Day(name: "T"), Day(name: "W"),Day(name: "Th"),Day(name: "F")])
        let weekends =  Set([Day(name: "M"), Day(name: "T"), Day(name: "W"),Day(name: "Th"),Day(name: "F")])
        let allDays = Set(Day.allDays)
        let selectedDays = Set(daysOfWeek.filter { $0.isSelected })
        if weekDays.isSubset(of: selectedDays) {
            return "Weekdays"
        } else if weekends.isSubset(of: selectedDays) {
            return "Weekends"
        } else if allDays.isSubset(of: selectedDays)  {
            return "Everyday"
        } else {
            var returnStr = ""
            for day in selectedDays {
                if let newDayChar = day.name.first {
                    let newDay = String(newDayChar)
                    returnStr.append(newDay)
                }
            }
            return returnStr
        }
    }

}



struct Day: Codable, Hashable {
 let name: String
 var isSelected: Bool = true
    
    static var allDays = [Day(name: "Su"),Day(name: "M"), Day(name: "T"), Day(name: "W"),Day(name: "Th"), Day(name: "F"), Day(name: "S")]
}
