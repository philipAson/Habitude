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
            ContentView()
                .tabItem{
                    Label("ToDo", systemImage: "list.bullet")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
