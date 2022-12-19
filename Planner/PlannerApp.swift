//
//  PlannerApp.swift
//  Planner
//
//  Created by Jillian Slater on 11/19/22.
//

import SwiftUI

@main
struct PlannerApp: App {
    @StateObject private var plannerData = PlannerData()
        
        var body: some Scene {
            WindowGroup {
                MainTabView(plannerData: plannerData)
                    .task {
                        plannerData.load()
                    }
                    .onChange(of: plannerData.days) { _ in
                        plannerData.save()
                    }
            }
        }
}
