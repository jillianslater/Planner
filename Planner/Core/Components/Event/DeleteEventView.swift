//
//  DeleteEventView.swift
//  Planner
//
//  Created by Jillian Slater on 12/6/22.
//

import SwiftUI

struct DeleteEventView: View {
    @ObservedObject var plannerData: PlannerData
    var sectionItem: SectionItem
    var body: some View {
        ZStack {
//            Color(.black)
            HStack (spacing: 15) {
                Spacer()
                
                Button(role: .destructive) {
                    plannerData.removeSectionItem(sectionItem: sectionItem)

                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct DeleteEventView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteEventView(plannerData: PlannerData(), sectionItem: SectionItem())
    }
}
