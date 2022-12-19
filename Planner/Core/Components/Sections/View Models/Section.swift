//
//  Section.swift
//  Planner
//
//  Created by Jillian Slater on 11/29/22.
//

import Foundation
import SwiftUI

class Section: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var type: Int// 0 - checklist, 1 - time
    var color: Int
    var items: [SectionItem] = []
    
    init(id: UUID = UUID(), title: String, type: Int, color: Int) {
        self.id = id
        self.title = title
        self.type = type
        self.color = color
        self.items = []
    }
    
    func getColor(color: Int) -> Color {
        switch (color) {
            case 1: return Color(red: 0.75, green: 0.37, blue: 0.40)
            case 2: return Color(red: 0.60, green: 0.17, blue: 0.02)
            case 3: return Color(red: 0.83, green: 0.53, blue: 0.17)
            case 4: return Color(red: 0.16, green: 0.42, blue: 0.55)
            case 5: return Color(red: 0.35, green: 0.56, blue: 0.63)
            case 6: return Color(red: 0.01, green: 0.25, blue: 0.36)
            case 7: return Color(red: 0.0, green: 0.19, blue: 0.28)
            default: return Color(red: 0.75, green: 0.37, blue: 0.40)
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Section: Equatable {}

func ==(lhs: Section, rhs: Section) -> Bool {
    let areEqual = lhs.title == rhs.title &&
        lhs.type == rhs.type &&
        lhs.color == rhs.color

    return areEqual
}

