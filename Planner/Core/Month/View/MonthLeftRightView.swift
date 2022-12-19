//
//  MonthLeftRightView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct MonthLeftRightView: View {
    @ObservedObject var plannerData: PlannerData
    @Binding var date: Date
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            HStack (spacing : 0) {
                ZStack {
                    HStack (spacing : 50) {
                        Button {
                            date = plannerData.getPreviousMonth(currentDate: date)
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        
                        Button {
                            date = plannerData.getNextMonth(currentDate: date)
                        } label: {
                            Image(systemName: "arrow.right")
                                .font(.title)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }
            }
        }
        .frame(height : 40)
    }
}

struct MonthLeftRightView_Previews: PreviewProvider {
    static var previews: some View {
        MonthLeftRightView(plannerData: PlannerData(), date: .constant(Date()))
    }
}
