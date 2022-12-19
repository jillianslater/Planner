//
//  File.swift
//  Planner
//
//  Created by Jillian Slater on 11/29/22.
//

import SwiftUI

class PlannerData: ObservableObject {
    @Published var days: [Day] = []
    
    init() {
        let calendar = Calendar.current
        let dateRange = addDates(from: Date(timeIntervalSinceNow: -94608000), to: Date(timeIntervalSinceNow: 94608000))
        for date in dateRange {
            let componentMonth = calendar.dateComponents([.month], from: date)
            let month_ = componentMonth.month
            let componentDay = calendar.dateComponents([.day], from: date)
            let day_ = componentDay.day
            let componentYear = calendar.dateComponents([.year], from: date)
            let year_ = componentYear.year
            let componentWeekday = calendar.dateComponents([.weekday], from: date)
            let weekday_ = componentWeekday.weekday
            days.append(Day(day: day_!, month: month_!, year: year_!, weekday: weekday_!))
        }
    }
    
    func addDates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    
    
    func add(_ day: Day) {
        days.append(day)
    }
        
    func remove(_ day: Day) {
        days.removeAll { $0.id == day.id}
    }
    
    func sortedEvents() -> Binding<[Day]> {
        Binding<[Day]>(
            get: {
                self.days
                    .sorted {$0.year < $1.year}
                    .sorted {$0.month < $1.month}
                    .sorted {$0.day < $1.day}
            },
            set: { days in
                for day in days {
                    if let index = self.days.firstIndex(where: { $0.id == day.id }) {
                        self.days[index] = day
                    }
                }
            }
        )
    }
    
    func getBindingToDay(_ day: Day) -> Binding<Day>? {
            Binding<Day>(
                get: {
                    guard let index = self.days.firstIndex(where: { $0.id == day.id }) else { return self.days[0] }
                    return self.days[index]
                },
                set: { day in
                    guard let index = self.days.firstIndex(where: { $0.id == day.id }) else { return }
                    self.days[index] = day
                }
            )
        }

    private static func getPlannerFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("days.data")
    }

    func load() {
        do {
            let fileURL = try PlannerData.getPlannerFileURL()
            let data = try Data(contentsOf: fileURL)
            days = try JSONDecoder().decode([Day].self, from: data)
            print("Events loaded: \(days.count)")
        } catch {
            print("Failed to load from file. Backup data used")
        }
    }
    
    func save() {
        do {
            let fileURL = try PlannerData.getPlannerFileURL()
            let data = try JSONEncoder().encode(days)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("Events saved")
        } catch {
            print("Unable to save")
        }
    }
    
    func getDay(currentDate: Date) -> Day {
        let calendar = Calendar.current
        let componentMonth = calendar.dateComponents([.month], from: currentDate)
        let month = componentMonth.month
        let componentDay = calendar.dateComponents([.day], from: currentDate)
        let day = componentDay.day
        let componentYear = calendar.dateComponents([.year], from: currentDate)
        let year = componentYear.year
        
        for date in self.days {
            if (date.day == day) {
                if (date.month == month) {
                    if (date.year == year) {
                        return date
                    }
                }
            }
        }
        return self.days[0]
    }
    
    func getWeek(currentDate: Date) -> [Day] {
        
        let calendar = Calendar.current
        let componentWeekday = calendar.dateComponents([.weekday], from: currentDate)
        let weekday: Int = componentWeekday.weekday ?? 1
        var week: [Day] = []
        var startDate = currentDate
        
        // subtract until start date - Sunday
        if (!(weekday == 1)) {
            for _ in 1...(weekday - 1) {
                startDate.addTimeInterval(-86400)
            }
        }

        var dateTemp = startDate
        var dayTemp: Day
        
        for _ in (1...7) {
            dayTemp = getDay(currentDate: dateTemp)
            for date in self.days {
                if (date.day == dayTemp.day) {
                    if (date.month == dayTemp.month) {
                        if (date.year == dayTemp.year) {
                            week.append(date)
                        }
                    }
                }
            }
            dateTemp.addTimeInterval(86400)
        }
        return week
    }
    
    func getMonth(currentDate: Date) -> [Day] {
        
        let calendar = Calendar.current
        let componentDay = calendar.dateComponents([.day], from: currentDate)
        let componentMonth = calendar.dateComponents([.month], from: currentDate)
        let day: Int = componentDay.day ?? 1
        let month: Int = componentMonth.month ?? 1
        var monthDates: [Day] = []
        var startDate = currentDate
        
        // subtract until start date = 1
        if (!(day == 1)) {
            for _ in 1...(day - 1) {
                startDate.addTimeInterval(-86400)
            }
        }
        
        var dateTemp = startDate
        var dayTemp = getDay(currentDate: dateTemp)
        
        while (dayTemp.month == month) {
            for date in self.days {
                if (date.day == dayTemp.day) {
                    if (date.month == dayTemp.month) {
                        if (date.year == dayTemp.year) {
                            monthDates.append(date)
                        }
                    }
                }
            }
            dateTemp.addTimeInterval(86400)
            dayTemp = getDay(currentDate: dateTemp)
        }
        return monthDates
    }
    
    func getFirstWeek(month: [Day]) -> [Day] {
        let startDayOfWeek: Int = month[0].weekday
        var firstWeek: [Day] = []
        
        for i in (0...(7 - startDayOfWeek)) {
            firstWeek.append(month[i])
        }
        
        return firstWeek
    }
    
    func getSecondWeek(month: [Day]) -> [Day] {
        let startDayOfWeek: Int = month[0].weekday
        var secondWeek: [Day] = []
        
        for i in ((8 - startDayOfWeek)...(14 - startDayOfWeek)) {
            secondWeek.append(month[i])
        }
        
        return secondWeek
    }
    
    func getThirdWeek(month: [Day]) -> [Day] {
        let startDayOfWeek: Int = month[0].weekday
        var thirdWeek: [Day] = []
        
        for i in ((15 - startDayOfWeek)...(21 - startDayOfWeek)) {
            thirdWeek.append(month[i])
        }
        
        return thirdWeek
    }
    
    func getFourthWeek(month: [Day]) -> [Day] {
        let startDayOfWeek: Int = month[0].weekday
        var fourthWeek: [Day] = []
        
        for i in ((22 - startDayOfWeek)...(28 - startDayOfWeek)) {
            fourthWeek.append(month[i])
        }
        
        return fourthWeek
    }
    
    func getFifthWeek(month: [Day]) -> [Day] {
        let startDayOfWeek: Int = month[0].weekday
        var fifthWeek: [Day] = []
        let start = 29 - startDayOfWeek
        if (start > (month.count - 1)) {
            return fifthWeek
        }
        var end = 35 - startDayOfWeek
        if (end > (month.count - 1)) {
            end = (month.count - 1)
        }
        
        for i in (start...end) {
            fifthWeek.append(month[i])
        }
        
        return fifthWeek
    }
    
    func getSixthWeek(month: [Day]) -> [Day] {
        let startDayOfWeek: Int = month[0].weekday
        var sixthWeek: [Day] = []
        let start = 36 - startDayOfWeek
        if (start > (month.count - 1)) {
            return sixthWeek
        }
        let end = (month.count - 1)
        
        for i in (start...end) {
            sixthWeek.append(month[i])
        }
        
        return sixthWeek
    }
    
    func getDateFromDay(day: Day) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = day.year
        dateComponents.month = day.month
        dateComponents.day = day.day
//        dateComponents.weekday = day.weekday
        
        let calendar = Calendar(identifier: .gregorian)
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }

    
    func getWeekBinding(week: [Day]) -> Binding<[Day]> {
        var week_ = week
        return Binding<[Day]>(
            get: {
                week_
            },
            set: { week_ = $0
            }
        )
    }
    
    func getSections(_ day: Day) -> Binding<[Section]> {
        Binding<[Section]>(
            get: {
                day.sections
            },
            set: { day.sections = $0
            }
        )
    }
    
    func addNewSection(_ section: Section) {
        for date in self.days {
            date.sections.append(section)
        }
        objectWillChange.send()
    }
    
    func removeSection(_ section: Section) {
        for date in self.days {
            date.sections.removeAll { $0.title == section.title}
        }
        objectWillChange.send()
    }
    
    func addNewItem(date: Day, section: Section, sectionItem: SectionItem) {
        for i in 0...(self.days.count - 1) {
            if (self.days[i] == date) {
                for j in 0...(date.sections.count - 1) {
                    if (date.sections[j] == section) {
                        self.days[i].sections[j].items.append(sectionItem)
                    }
                }
            }
        }
        objectWillChange.send()
    }
    
    func starSectionItem(sectionItem: SectionItem, section: Section, day: Day) {
        for i in 0...(self.days.count - 1) {
            if (self.days[i] == day) {
                for j in 0...(day.sections.count - 1) {
                    if (day.sections[j] == section) {
                        for k in 0...(day.sections[j].items.count - 1) {
                            if (day.sections[j].items[k] == sectionItem) {
                                day.sections[j].items[k].starred.toggle()
                            }
                        }
                    }
                }
            }
        }
        objectWillChange.send()
    }
    
    func sectionStarred(sectionItem: SectionItem, section: Section, day: Day) -> Bool {
        for i in 0...(self.days.count - 1) {
            if (self.days[i] == day) {
                for j in 0...(day.sections.count - 1) {
                    if (day.sections[j] == section) {
                        for k in 0...(day.sections[j].items.count - 1) {
                            if (day.sections[j].items[k] == sectionItem) {
                                return day.sections[j].items[k].starred
                            }
                        }
                    }
                }
            }
        }
        return false
    }
    
    func removeSectionItem(sectionItem: SectionItem) {
        for date in self.days {
            for section in date.sections {
                date.sections.removeAll { $0.id == section.id}
            }
        }
        objectWillChange.send()
    }
    
    func updateSectionItem(sectionItem: ChecklistSectionItem, section: Section, day: Day) {
        for i in 0...(self.days.count - 1) {
            if (self.days[i] == day) {
                for j in 0...(day.sections.count - 1) {
                    if (day.sections[j] == section) {
                        for k in 0...(day.sections[j].items.count - 1) {
                            if (day.sections[j].items[k].name == sectionItem.name) {
                                if let item = day.sections[j].items[k] as? ChecklistSectionItem {
                                    item.progress = sectionItem.progress
                                }
                            }
                        }
                    }
                }
            }
        }
        objectWillChange.send()
    }
    
    func getNextMonth(currentDate: Date) -> Date {
        let calendar = Calendar.current
        let componentMonth = calendar.dateComponents([.month], from: currentDate)
        let componentYear = calendar.dateComponents([.year], from: currentDate)
        let day: Int = 1
        var month: Int = componentMonth.month ?? 1
        var year: Int = componentYear.year ?? 2022
        if (month == 12) {
            month = 1
            year += 1
        }
        else {
            month += 1
        }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar_ = Calendar(identifier: .gregorian)
        if let date = calendar_.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }
    
    func getPreviousMonth(currentDate: Date) -> Date {
        let calendar = Calendar.current
        let componentMonth = calendar.dateComponents([.month], from: currentDate)
        let componentYear = calendar.dateComponents([.year], from: currentDate)
        let day: Int = 1
        var month: Int = componentMonth.month ?? 1
        var year: Int = componentYear.year ?? 2022
        if (month == 1) {
            month = 12
            year -= 1
        }
        else {
            month -= 1
        }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar_ = Calendar(identifier: .gregorian)
        if let date = calendar_.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }
    
    func sendUpdate() {
        objectWillChange.send()
    }
}

extension Date {
    static func from(month: Int, day: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar(identifier: .gregorian)
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }
}
