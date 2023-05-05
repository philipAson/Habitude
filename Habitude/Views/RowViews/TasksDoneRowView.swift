//
//  TasksDoneRowView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-05-04.
//

import SwiftUI

struct TasksDoneRowView: View {
    let task : Task
    let gold = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)
    
    var body: some View {
        HStack {
            Text(task.name)
            Spacer()
            Image(systemName: "checkmark.seal")
        }
        .ignoresSafeArea()
        .foregroundColor(Color(uiColor: gold))
    }
}

