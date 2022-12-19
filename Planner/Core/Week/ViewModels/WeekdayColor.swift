//
//  WeekdayColor.swift
//  Planner
//
//  Created by Jillian Slater on 12/7/22.
//

import Foundation
import SwiftUI

class WeekdayColor {
    let colors =
    [Color(red: 0.75, green: 0.37, blue: 0.40),
     Color(red: 0.60, green: 0.17, blue: 0.02),
     Color(red: 0.83, green: 0.53, blue: 0.17),
     Color(red: 0.35, green: 0.56, blue: 0.63),
     Color(red: 0.16, green: 0.42, blue: 0.55),
     Color(red: 0.01, green: 0.25, blue: 0.36),
     Color(red: 0.0, green: 0.19, blue: 0.28)]
    
    func getColor(day: Day) -> Color {
        if ((day.weekday) < 8) {
            if ((day.weekday) >= 1) {
                return colors[(day.weekday) - 1]
            }
        }
        return colors[0]
    }
}
