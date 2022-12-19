//
//  ChecklistWeekView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct ChecklistWeekView: View {
    @ObservedObject var plannerData: PlannerData
    var section: Section
    var day: Day
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
//            Color(.black)
            VStack (spacing : 0) {
                
                // section name
                ZStack {
                    Text(section.title)
                        .font(.title).bold()
                        .foregroundColor(.white)
                }
                .padding(.bottom, 10)


                ScrollView {
                    VStack (alignment: .leading, spacing : 10) {
                        ForEach(section.items) { item in
                            ChecklistEventView(plannerData: plannerData, section: section, day: day, sectionItem: item as! ChecklistSectionItem)
                            
                            Divider()
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ChecklistWeekView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistWeekView(plannerData: PlannerData(), section: Section(title: "", type: 0, color: 0), day: Day(day: 1, month: 1, year: 2021, weekday: 1))
    }
}
