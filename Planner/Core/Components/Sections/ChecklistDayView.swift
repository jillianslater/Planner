//
//  ChecklistSectionView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct ChecklistDayView: View {
    @ObservedObject var plannerData: PlannerData
    var section: Section
    var day: Day
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isPresentingAddItemView = false
    @State private var newItem = ChecklistSectionItem()
    
    var body: some View {
        ZStack {
//            Color(.black)
            VStack (spacing : 0) {
                // section name
                ZStack {
                    Text(section.title)
                        .font(.title).bold()
                        .foregroundColor(.white)
                    
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
                        ForEach(section.items) { item in
                            HStack {
                                ChecklistEventView(plannerData: plannerData, section: section, day: day, sectionItem: item as! ChecklistSectionItem)
                                
                                StarEditView(plannerData: plannerData, sectionItem: item, section: section, day: day)
                                    .frame(maxWidth: 40)
                                
//                                DeleteEventView(plannerData: plannerData, sectionItem: item)
                            }
                            
                            Divider()
                        }
                        
                        Button(action: {
                            newItem = ChecklistSectionItem()
                            isPresentingAddItemView = true
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        })
                        .font(.title2)
                        .foregroundColor(.black)
                        .sheet(isPresented: $isPresentingAddItemView) {
                            NavigationView {
                                NewChecklistItemView(sectionItem: $newItem)
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

struct ChecklistDayView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistDayView(plannerData: PlannerData(), section: Section(title: "", type: 1, color: 1), day: Day(day: 1, month: 1, year: 2022, weekday: 1))
    }
}
