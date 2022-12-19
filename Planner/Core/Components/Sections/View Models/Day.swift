//
//  Day.swift
//  Planner
//
//  Created by Jillian Slater on 11/29/22.
//

import Foundation

class Day: Identifiable, Hashable, Codable, ObservableObject {
    var id: UUID
    var day: Int
    var month: Int
    var year: Int
    var weekday: Int
    var sections: [Section]
    
    init(id: UUID = UUID(), day: Int, month: Int, year: Int, weekday: Int) {
        self.id = id
        self.day = day
        self.month = month
        self.year = year
        self.weekday = weekday
        self.sections = [Section(title: "Events", type: 1, color: 1),
                         Section(title: "To Do List", type: 0, color: 2)]
    }
    
    func monthToString(month: Int) -> String {
        switch month {
            case 1: return "January"
            case 2: return "February"
            case 3: return "March"
            case 4: return "April"
            case 5: return "May"
            case 6: return "June"
            case 7: return "July"
            case 8: return "August"
            case 9: return "September"
            case 10: return "October"
            case 11: return "November"
            case 12: return "December"
            default: return "Invalid Month: " + String(month)
        }
    }
    
    func weekdayToString(weekday: Int) -> String {
        switch weekday {
            case 1: return "Sunday"
            case 2: return "Monday"
            case 3: return "Tuesday"
            case 4: return "Wednesday"
            case 5: return "Thursday"
            case 6: return "Friday"
            case 7: return "Saturday"
            default: return "Invalid Weekday: " + String(weekday)
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Day: Equatable {}

func ==(lhs: Day, rhs: Day) -> Bool {
    let areEqual = lhs.day == rhs.day &&
        lhs.month == rhs.month &&
        lhs.year == rhs.year

    return areEqual
}
