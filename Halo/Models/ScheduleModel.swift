//
//  ScheduleModel.swift
//  Halo
//
//  Created by Dante Kim on 10/21/23.
//

import Foundation

struct Schedule: Codable, Identifiable {
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
    
    var isActive: Bool {
        if isSuggested {
            return false
        } else {
            return true
        }
    }
    
    var isAllDay: Bool {
        if ((starts == Calendar.current.date(from: DateComponents(hour: 0, minute: 0))! && ends == Calendar.current.date(from: DateComponents(hour: 23, minute: 59))!)) {
            return true
        }
        return false
    }
    
    static var suggestedSchedules = [Schedule(title: "🧘 Precious Mode",  breaks: true, starts:  Calendar.current.date(from: DateComponents(hour: 0, minute: 0))!, ends:  Calendar.current.date(from: DateComponents(hour: 23, minute: 59))!, daysOfWeek: [Day(name: "S"),Day(name: "M"), Day(name: "T"), Day(name: "W"),Day(name: "T"),Day(name: "F"), Day(name: "S")], isSuggested: true, description: "Block selected apps the entire day, you can still unlock with coins. At the end of the day you get a focus bonus 🎁")]
        
    static var savedSchedules = [Schedule]()
    static var templateSchedule = Schedule(title: "💎 My Schedule", breaks: true, starts:  Calendar.current.date(from: DateComponents(hour: 0, minute: 0))!, ends: Calendar.current.date(from: DateComponents(hour: 23, minute: 59))!, daysOfWeek: [Day(name: "Su"),Day(name: "M"), Day(name: "Tu"), Day(name: "W"),Day(name: "Th"),Day(name: "F"),Day(name: "Sa")], isSuggested: true, description: "")
    
    var dayFormatted: String {
        let weekDays =  Set([Day(name: "M"), Day(name: "Tu"), Day(name: "W"),Day(name: "Th"),Day(name: "F")])
        let weekends =  Set([Day(name: "M"), Day(name: "Tu"), Day(name: "W"),Day(name: "Th"),Day(name: "F")])
        let allDays = Set([Day(name: "S"),Day(name: "M"), Day(name: "T"), Day(name: "W"),Day(name: "T"), Day(name: "F"), Day(name: "S")])
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
}
