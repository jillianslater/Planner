//
//  WeekDayHeaderView.swift
//  Planner
//
//  Created by Jillian Slater on 11/25/22.
//

import SwiftUI

struct WeekDayHeaderView: View {
    @ObservedObject var plannerData: PlannerData
    var day: Int
    var weekday: String
    var currentDate: Date
    @Environment(\.colorScheme) var colorScheme
    @State private var isPresentingDayView = false

    
    var body: some View {
        ZStack {
            
            HStack (spacing : 20) {
                Text(String(day))
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                
                Divider()
                
                Text(weekday)
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Divider()
                
                Button(action: {
                    isPresentingDayView = true
                }, label: {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .foregroundColor(.white)
                            .font(.headline)
                })
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .sheet(isPresented: $isPresentingDayView) {
                    NavigationView {
                        DayView(plannerData: plannerData, currentDate: currentDate)
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
            .frame(height : 50)
            .padding(.horizontal, 10)
        }
    }
}

struct WeekDayHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDayHeaderView(plannerData: PlannerData(), day: 1, weekday: "Monday", currentDate: Date())
    }
}
