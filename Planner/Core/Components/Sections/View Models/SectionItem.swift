//
//  SectionItem.swift
//  Planner
//
//  Created by Jillian Slater on 11/29/22.
//

import Foundation

class SectionItem: Identifiable, Hashable, Codable {
    var name: String = ""
    var type: Int = 0 // 0 - checklist, 1 - time, 2 - list
    var starred: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class ChecklistSectionItem: SectionItem {
    var progress: Int = 0 // 0 - not started, 1 - in progress, 2 - not started
}

class TimeSectionItem: SectionItem {
    var hour: Int = 0
    var minute: Int = 0
}

class ListSectionItem: SectionItem {

}

extension SectionItem: Equatable {}

func ==(lhs: SectionItem, rhs: SectionItem) -> Bool {
    let areEqual = lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.type == rhs.type

    return areEqual
}
