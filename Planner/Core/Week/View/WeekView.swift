//
//  WeekView.swift
//  Planner
//
//  Created by Jillian Slater on 11/25/22.
//

import SwiftUI

struct WeekView: View {
    @ObservedObject var plannerData: PlannerData
    @State private var currentDate = Date()
    @Environment(\.colorScheme) var colorScheme
    var weekdayColor = WeekdayColor()
     
    var body: some View {
        ZStack {
            ScrollView {
                VStack (spacing : 10) {
                    
                    WeekLeftRightView(currentDate: $currentDate)
                    
                    ForEach(plannerData.getWeekBinding(week: plannerData.getWeek(currentDate: currentDate))) { $day in
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(weekdayColor.getColor(day: day))
                            
                            VStack {
                                WeekDayHeaderView(plannerData: plannerData, day: day.day, weekday: day.weekdayToString(weekday: day.weekday), currentDate: plannerData.getDateFromDay(day: day))
                                    .padding(.top)

                                Divider()
                                
                                WeekDayView(plannerData: plannerData, day: day)
                                    .frame(height: 150)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView(plannerData: PlannerData())
    }
}

