//
//  TimeEventWeekView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct TimeEventWeekView: View {
    @ObservedObject var plannerData: PlannerData
    var section: Section
    var day: Day
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
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
                        // edit - should switch between empty, half filled
                        //        and filled on tap
                        ForEach(section.items) { item in
                            ZStack {
                                TimeEventView(sectionItem: item as! TimeSectionItem)
                            }
                            
                            Divider()
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TimeEventWeekView_Previews: PreviewProvider {
    static var previews: some View {
        TimeEventWeekView(plannerData: PlannerData(), section: Section(title: "", type: 0, color: 0), day: Day(day: 1, month: 1, year: 2021, weekday: 1))
    }
}
