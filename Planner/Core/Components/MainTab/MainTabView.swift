//
//  TabView.swift
//  Planner
//
//  Created by Jillian Slater on 11/25/22.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var plannerData: PlannerData
    @State var selectedIndex = 0
    
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            DayView(plannerData: plannerData)
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "rectangle.portrait")
                }.tag(0)
            
            WeekView(plannerData: plannerData)
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                }.tag(1)
            
            MonthView(plannerData: plannerData)
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "calendar")
                }.tag(2)
        }
        //.foregroundColor(.white)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(plannerData: PlannerData())
    }
}
