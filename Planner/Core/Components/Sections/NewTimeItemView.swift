//
//  NewTimeItemView.swift
//  Planner
//
//  Created by Jillian Slater on 12/4/22.
//

import SwiftUI

struct NewTimeItemView: View {
    @Binding var sectionItem: TimeSectionItem
    @Environment(\.colorScheme) var colorScheme
    @State private var time = Date()
    
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
                
                DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                
                ExecuteCode {
                    let calendar = Calendar.current
                    sectionItem.type = 1
                    sectionItem.hour = calendar.component(.hour, from: time)
                    sectionItem.minute = calendar.component(.minute, from: time)
                }
            }
            .padding(.bottom, 200)
            .padding(.horizontal)
            
        }
    }
}

struct NewTimeItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTimeItemView(sectionItem: .constant(TimeSectionItem()))
    }
}

struct ExecuteCode : View {
    init( _ codeToExec: () -> () ) {
        codeToExec()
    }
    
    var body: some View {
        return EmptyView()
    }
}
