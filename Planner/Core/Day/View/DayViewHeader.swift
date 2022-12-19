//
//  DayViewHeader.swift
//  Planner
//
//  Created by Jillian Slater on 11/25/22.
//

import SwiftUI

struct DayViewHeader: View {
    var month: String
    var day: Int
    var year: Int
    var weekday: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (alignment : .leading) {
            
            HStack {
                Text(String(weekday))
                    .font(.headline).bold()
                    .padding(.leading)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Spacer()
            }
            
            HStack {
                Text(month + " " + String(day))
                    .font(.largeTitle).bold()
                    .padding(.leading)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Text(String(year))
                    .font(.headline)
                    .offset(y: 5)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
        
            }
        }
    }
}

struct DayViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        DayViewHeader(month: "January", day: 1, year: 2022, weekday: "Saturday")
    }
}
