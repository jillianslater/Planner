//
//  WeekLeftRightView.swift
//  Planner
//
//  Created by Jillian Slater on 11/25/22.
//

import SwiftUI

struct WeekLeftRightView: View {
    @Binding var currentDate: Date
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            HStack (spacing : 0) {
                ZStack {
                    HStack (spacing : 50) {
                        Button {
                            currentDate.addTimeInterval(-604800)
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        
                        Button {
                            currentDate.addTimeInterval(604800)
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

struct WeekLeftRightView_Previews: PreviewProvider {
    static var previews: some View {
        WeekLeftRightView(currentDate: .constant(Date()))
    }
}
