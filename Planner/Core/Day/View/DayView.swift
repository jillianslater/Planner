//
//  DayView.swift
//  Planner
//
//  Created by Jillian Slater on 11/25/22.
//

import SwiftUI

struct DayView: View {
    @ObservedObject var plannerData: PlannerData
    @State var currentDate = Date()
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isPresentingAddView = false
    @State private var newSection = Section(title: "", type: 1, color: 1)
   
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing : 10) {
                    
                    DayLeftRightView(currentDate: $currentDate)
                    
                    DayViewHeader(month: plannerData.getDay(currentDate: currentDate).monthToString(month: plannerData.getDay(currentDate: currentDate).month), day: plannerData.getDay(currentDate: currentDate).day, year: plannerData.getDay(currentDate: currentDate).year, weekday: plannerData.getDay(currentDate: currentDate).weekdayToString(weekday: plannerData.getDay(currentDate: currentDate).weekday))
                    
                    ForEach(plannerData.getSections(plannerData.getDay(currentDate: currentDate))) { $section in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(section.getColor(color: section.color))
                            // 0 - checklist, 1 - time, 2 - list
                            switch (section.type) {
                            case 0:
                                ChecklistDayView(plannerData: plannerData, section: section, day: plannerData.getDay(currentDate: currentDate))
                            case 1: TimeEventDayView(plannerData: plannerData, section: section, day: plannerData.getDay(currentDate: currentDate))
                            case 2: TimeEventDayView(plannerData: plannerData, section: section, day: plannerData.getDay(currentDate: currentDate))
                            default: ChecklistDayView(plannerData: plannerData, section: section, day: plannerData.getDay(currentDate: currentDate))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(height : 250)
                
                    Button(action: {
                        newSection = Section(title: "", type: 1, color: 1)
                        isPresentingAddView = true
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    })
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()
                    .sheet(isPresented: $isPresentingAddView) {
                        NavigationView {
                            NewSectionView(section: $newSection)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Cancel") {
                                            newSection = Section(title: "", type: 1, color: 1)
                                            isPresentingAddView = false
                                        }
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Add Section") {
                                            plannerData.addNewSection(newSection)
                                            isPresentingAddView = false
                                        }
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
//                                        .disabled(newSection.title.isEmpty)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(plannerData: PlannerData())
    }
}



