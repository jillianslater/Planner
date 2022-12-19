//
//  ChecklistEventView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct ChecklistEventView: View {
    @ObservedObject var plannerData: PlannerData
    var section: Section
    var day: Day
    var sectionItem: ChecklistSectionItem
    
    var body: some View {
        ZStack {
//            Color(.black)
            HStack {
                Button {
                    switch (sectionItem.progress) {
                        case 0: sectionItem.progress = 1
                        case 1: sectionItem.progress = 2
                        default: sectionItem.progress = 0
                    }
                    plannerData.updateSectionItem(sectionItem: sectionItem, section: section, day: day)
                } label: {
                    Image(systemName: getImageName(sectionItem.progress))
                        .foregroundColor(.white)
                }

                Text(sectionItem.name)
                    .foregroundColor(.white)

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    func getImageName(_ number: Int) -> String {
        switch (number) {
            case 1: return "circle.lefthalf.filled"
            case 2: return "circle.fill"
            default: return "circle"
        }
    }
}

struct ChecklistEventView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistEventView(plannerData: PlannerData(), section: Section(title: "", type: 1, color: 1), day: Day(day: 1, month: 1, year: 2022, weekday: 1), sectionItem: ChecklistSectionItem())
    }
}
