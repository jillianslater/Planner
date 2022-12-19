//
//  MonthHeaderView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct MonthHeaderView: View {
    var month: String
    var year: Int
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (alignment : .leading) {
            HStack {
                Text(month)
                    .font(.largeTitle).bold()
                    .padding(.leading)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Text(String(year))
                    .font(.headline)
                    .offset(y: 5)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Spacer()
            }
        }
    }
}

struct MonthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MonthHeaderView(month: "January", year: 2022)
    }
}
