//
//  MainView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ToDoView()
                .tabItem{
                    Label("ToDo", systemImage: "calendar.day.timeline.leading")
                }
            
            CreateTaskView()
                .tabItem{
                    Label("Create Task", systemImage: "text.badge.plus")
                }
            DayPlannerView()
                .tabItem{
                    Label("Planner", systemImage: "calendar.badge.plus")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
