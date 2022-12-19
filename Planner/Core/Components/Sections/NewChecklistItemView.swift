//
//  NewChecklistItemView.swift
//  Planner
//
//  Created by Jillian Slater on 12/4/22.
//

import SwiftUI

struct NewChecklistItemView: View {
    @Binding var sectionItem: ChecklistSectionItem
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack (alignment : .leading, spacing: 30) {
                Text("Add New Item")
                    .font(.title)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                
                TextField(
                    "Name: ",
                    text: $sectionItem.name
                )
            }
            .padding(.bottom, 200)
            .padding(.horizontal)
            
        }
    }
}

struct NewChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewChecklistItemView(sectionItem: .constant(ChecklistSectionItem()))
    }
}
