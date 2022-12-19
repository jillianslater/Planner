//
//  WeekDayView.swift
//  Planner
//
//  Created by Jillian Slater on 11/25/22.
//

import SwiftUI

struct WeekDayView: View {
    @ObservedObject var plannerData: PlannerData
    var day: Day
    
    var body: some View {
        ZStack {
            if (day.sections.count >= 2) {
                HStack (spacing : 20) {
                    switch (day.sections[0].type) {
                        case 0: ChecklistWeekView(plannerData: plannerData, section: day.sections[0], day: day)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        case 1: TimeEventWeekView(plannerData: plannerData, section: day.sections[0], day: day)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        default: TimeEventWeekView(plannerData: plannerData, section: day.sections[0], day: day)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    Divider()
                    switch (day.sections[1].type) {
                        case 0: ChecklistWeekView(plannerData: plannerData, section: day.sections[1], day: day)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        case 1: TimeEventWeekView(plannerData: plannerData, section: day.sections[1], day: day)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        default: TimeEventWeekView(plannerData: plannerData, section: day.sections[1], day: day)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
                .frame(maxHeight : 250)
            }
            else if (day.sections.count == 1) {
                HStack (spacing : 20) {
                    switch (day.sections[0].type) {
                        case 0: ChecklistWeekView(plannerData: plannerData, section: day.sections[0], day: day)
                            .frame(alignment: .leading)
                        case 1: TimeEventWeekView(plannerData: plannerData, section: day.sections[0], day: day)
                            .frame(alignment: .leading)
                        default: TimeEventWeekView(plannerData: plannerData, section: day.sections[0], day: day)
                            .frame(alignment: .leading)
                    }
                    Spacer()
                }
                .frame(maxHeight : 250)
            }
        }
    }
}

struct WeekDayView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDayView(plannerData: PlannerData(), day: Day(day: 1, month: 1, year: 2021, weekday: 1))
    }
}
