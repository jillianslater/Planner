//
//  MonthView.swift
//  Planner
//
//  Created by Jillian Slater on 11/25/22.
//

import SwiftUI

struct MonthView: View {
    @ObservedObject var plannerData: PlannerData
    @State private var date = Date()
    @State private var month = Month()
    var monthColor = MonthColor()
    @Environment(\.colorScheme) var colorScheme
    @State private var isPresentingColorView = false
    @State private var isPresentingDayView = false

    
    var body: some View {
        
    
        VStack (spacing: 0) {
            
            MonthLeftRightView(plannerData: plannerData, date: $date)
            ZStack {
                MonthHeaderView(month: plannerData.getDay(currentDate: date).monthToString(month: plannerData.getDay(currentDate: date).month), year: plannerData.getDay(currentDate: date).year)
                    .padding(.vertical, 10)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        isPresentingColorView = true
                    }, label: {
                        Image(systemName: "paintpalette")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    })
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()
                    .sheet(isPresented: $isPresentingColorView) {
                        NavigationView {
                            MonthColorView(month: $month)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Cancel") {
                                            isPresentingColorView = false
                                        }
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Save") {
                                            plannerData.sendUpdate()
                                            isPresentingColorView = false
                                        }
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    }
                                }
                        }
                    }
                }
            }
            
            ScrollView(.horizontal) {
                
                VStack {
                    
                    HStack {
                        Text("Sunday")
                            .frame(minWidth: 80, alignment: .center)
                        
                        Text("Monday")
                            .frame(minWidth: 80, alignment: .center)
                        
                        Text("Tuesday")
                            .frame(minWidth: 80, alignment: .center)
                        
                        Text("Wednesday")
                            .frame(minWidth: 80, alignment: .center)
                        
                        Text("Thursday")
                            .frame(minWidth: 80, alignment: .center)
                        
                        Text("Friday")
                            .frame(minWidth: 80, alignment: .center)
                        
                        Text("Saturday")
                            .frame(minWidth: 80, alignment: .center)
                    }
                    
                    // week one
                    HStack {
                        if (plannerData.getFirstWeek(month: plannerData.getMonth(currentDate: date)).count < 7) {
                            ForEach(1...(7 - (plannerData.getFirstWeek(month: plannerData.getMonth(currentDate: date)).count)), id: \.self) {_ in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.clear)
                                    .frame(minWidth: 80)
                            }
                        }
                        
                        ForEach(plannerData.getWeekBinding(week: plannerData.getFirstWeek(month: plannerData.getMonth(currentDate: date)))) { $day in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(monthColor.getColor(colorNum: month.colorNum))
                                    
                                    MonthDayView(plannerData: plannerData, day: day)
                                }
                                .frame(minWidth: 80)
                        }
                    }
                    
                    HStack {
                        ForEach(plannerData.getWeekBinding(week: plannerData.getSecondWeek(month: plannerData.getMonth(currentDate: date)))) { $day in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(monthColor.getColor(colorNum: month.colorNum))
                                
                                MonthDayView(plannerData: plannerData, day: day)
                            }
                            .frame(minWidth: 80)
                        }
                    }
                    
                    HStack {
                        ForEach(plannerData.getWeekBinding(week: plannerData.getThirdWeek(month: plannerData.getMonth(currentDate: date)))) { $day in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(monthColor.getColor(colorNum: month.colorNum))
                                
                                MonthDayView(plannerData: plannerData, day: day)
                            }
                            .frame(minWidth: 80)
                        }
                    }
                    
                    HStack {
                        ForEach(plannerData.getWeekBinding(week: plannerData.getFourthWeek(month: plannerData.getMonth(currentDate: date)))) { $day in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(monthColor.getColor(colorNum: month.colorNum))
                                
                                MonthDayView(plannerData: plannerData, day: day)
                            }
                            .frame(minWidth: 80)
                        }
                    }
                    
                    HStack {
                        ForEach(plannerData.getWeekBinding(week: plannerData.getFifthWeek(month: plannerData.getMonth(currentDate: date)))) { $day in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(monthColor.getColor(colorNum: month.colorNum))
                                
                                MonthDayView(plannerData: plannerData, day: day)
                            }
                            .frame(minWidth: 80)
                        }
                        if ((plannerData.getFifthWeek(month: plannerData.getMonth(currentDate: date)).count) < 7) {
                            ForEach((plannerData.getFifthWeek(month: plannerData.getMonth(currentDate: date)).count...6), id: \.self) {_ in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.clear)
                                    .frame(minWidth: 80)
                            }
                        }
                    }
                    
                    HStack {
                        ForEach(plannerData.getWeekBinding(week: plannerData.getSixthWeek(month: plannerData.getMonth(currentDate: date)))) { $day in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(monthColor.getColor(colorNum: month.colorNum))
                                
                                MonthDayView(plannerData: plannerData, day: day)
                            }
                            .frame(minWidth: 80)
                        }
                        if ((plannerData.getSixthWeek(month: plannerData.getMonth(currentDate: date)).count) < 7) {
                            ForEach((plannerData.getSixthWeek(month: plannerData.getMonth(currentDate: date)).count...6), id: \.self) {_ in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.clear)
                                    .frame(minWidth: 80)
                            }
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(plannerData: PlannerData())
    }
}
