//
//  TaskListView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-20.
//

import SwiftUI

struct RowView: View {
    let task : Task
    let userData : UserDataVM
    
    let colors: [String: Color] = ["orange": .orange, "teal": .teal, "cyan": .cyan, "mint": .mint, "blue": .blue]
    
    var body: some View {
        HStack {
            Text(task.name)
            
        }
        .ignoresSafeArea()
        .foregroundColor(colors[task.color, default: .black])
    }
    
}

//struct RowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RowView()
//    }
//}
