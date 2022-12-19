//
//  MonthColor.swift
//  Planner
//
//  Created by Jillian Slater on 12/11/22.
//

import Foundation
import SwiftUI

class Month {
    var colorNum: Int = 1
}

class MonthColor {
    let colors =
    [Color(red: 0.75, green: 0.37, blue: 0.40),
     Color(red: 0.60, green: 0.17, blue: 0.02),
     Color(red: 0.83, green: 0.53, blue: 0.17),
     Color(red: 0.35, green: 0.56, blue: 0.63),
     Color(red: 0.16, green: 0.42, blue: 0.55),
     Color(red: 0.01, green: 0.25, blue: 0.36),
     Color(red: 0.0, green: 0.19, blue: 0.28)]
    
    func getColor(colorNum: Int) -> Color {
        if (colorNum < 8) {
            if (colorNum >= 1) {
                return colors[colorNum - 1]
            }
        }
        return colors[0]
    }
}
