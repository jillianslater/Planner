//
//  StarEditView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct StarEditView: View {
    @ObservedObject var plannerData: PlannerData
    var sectionItem: SectionItem
    var section: Section
    var day: Day
    
    var body: some View {
        ZStack {
//            Color(.black)
            HStack (spacing: 15) {
                Spacer()
                
                Button {
                    plannerData.starSectionItem(sectionItem: sectionItem, section: section, day: day)
                    
                } label: {
                    Image(systemName: plannerData.sectionStarred(sectionItem: sectionItem, section: section, day: day) ? "star.fill" : "star")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct StarEditView_Previews: PreviewProvider {
    static var previews: some View {
        StarEditView(plannerData: PlannerData(), sectionItem: SectionItem(), section: Section(title: "", type: 1, color: 1), day: Day(day: 1, month: 1, year: 2022, weekday: 1))
    }
}
