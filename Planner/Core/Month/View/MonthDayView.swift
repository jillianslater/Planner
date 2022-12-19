//
//  MonthDayView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct MonthDayView: View {
    @ObservedObject var plannerData: PlannerData
    @State private var isPresentingDayView = false
    var day: Day
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if (plannerData.getDay(currentDate: Date()).day == day.day) {
                if (plannerData.getDay(currentDate: Date()).month == day.month) {
                    if (plannerData.getDay(currentDate: Date()).year == day.year) {
                        Circle().strokeBorder(.white, lineWidth: 1)
                            .frame(width: 50, height: 50)
                        
                    }
                }
            }
            
            Button(action: {
                isPresentingDayView = true
            }, label: {
                Text("\(day.day)")
                    .foregroundColor(.white)
            })
            .font(.title2)
            .foregroundColor(.black)
            .padding()
            .sheet(isPresented: $isPresentingDayView) {
                NavigationView {
                    DayView(plannerData: plannerData, currentDate: plannerData.getDateFromDay(day: day))
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button("Done") {
                                    isPresentingDayView = false
                                }
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                        }
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    
    }
}

struct MonthDayView_Previews: PreviewProvider {
    static var previews: some View {
        MonthDayView(plannerData: PlannerData(), day: Day(day: 1, month: 1, year: 2022, weekday: 1))
    }
}
