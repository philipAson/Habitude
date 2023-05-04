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
            
            OverView()
                .tabItem{
                    Label("Overview", systemImage: "chart.bar.fill")
                }
            
            EditTasksView()
                .tabItem{
                    Label("Edit Tasks", systemImage: "doc.badge.gearshape")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
