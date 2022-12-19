//
//  TimeEventView.swift
//  Planner
//
//  Created by Jillian Slater on 11/27/22.
//

import SwiftUI

struct TimeEventView: View {
    var sectionItem: TimeSectionItem
    var body: some View {
        HStack (spacing: 20) {
            Text(getTimeString(hour: sectionItem.hour, minute: sectionItem.minute))
                .foregroundColor(.white)
            
            Text(sectionItem.name)
                .foregroundColor(.white)
            
            Spacer()
        }
    }
    
    func getTimeString(hour: Int, minute: Int) -> String {
        var s = ""
        if (hour == 0) {
            s += "12"
        }
        else if (hour > 12) {
            s += String(hour - 12)
        }
        else {
            s += String(hour)
        }
        s += ":"
        if (minute < 10) {
            s += "0" + String(minute)
        }
        else {
            s += String(minute)
        }
        s += " "
        if (hour >= 12) {
            s += "PM"
        }
        else {
            s += "AM"
        }
        return s
    }
}

struct TimeEventView_Previews: PreviewProvider {
    static var previews: some View {
        TimeEventView(sectionItem: TimeSectionItem())
    }
}
