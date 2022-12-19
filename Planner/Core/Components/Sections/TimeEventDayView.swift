//
//  TimeEventDayView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct TimeEventDayView: View {
    @ObservedObject var plannerData: PlannerData
    var section: Section
    var day: Day
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isPresentingAddItemView = false
    @State private var newItem = TimeSectionItem()
    
    var body: some View {
        ZStack {
            VStack (spacing : 0) {
                // section name
                ZStack {
                    Text(section.title)
                        .font(.title).bold()
                        .foregroundColor(.white)
//                        .padding(.top)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            plannerData.removeSection(section)
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                
                ScrollView {
                    VStack (alignment: .leading, spacing : 10) {
                        // edit - should switch between empty, half filled
                        //        and filled on tap
                        ForEach(section.items) { item in
                            HStack {
                                TimeEventView(sectionItem: item as! TimeSectionItem)
                                
                                StarEditView(plannerData: plannerData, sectionItem: item, section: section, day: day)
                                    .frame(maxWidth: 40)
                            }
                            
                            Divider()
                        }
                        
                        Button(action: {
                            newItem = TimeSectionItem()
                            isPresentingAddItemView = true
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        })
                        .font(.title2)
                        .foregroundColor(.black)
                        .sheet(isPresented: $isPresentingAddItemView) {
                            NavigationView {
                                NewTimeItemView(sectionItem: $newItem)
                                    .toolbar {
                                        ToolbarItem(placement: .cancellationAction) {
                                            Button("Cancel") {
                                                isPresentingAddItemView = false
                                            }
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                        }
                                        ToolbarItem(placement: .confirmationAction) {
                                            Button("Add Item") {
                                                plannerData.addNewItem(date: day, section: section, sectionItem: newItem)
                                                isPresentingAddItemView = false
                                            }
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                            //.disabled(newItem.name == "")
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct TimeEventDayView_Previews: PreviewProvider {
    static var previews: some View {
        TimeEventDayView(plannerData: PlannerData(), section: Section(title: "", type: 1, color: 1), day: Day(day: 1, month: 1, year: 2022, weekday: 1))
    }
}
