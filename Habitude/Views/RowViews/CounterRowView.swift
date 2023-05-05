//
//  CounterRowView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-05-04.
//

import SwiftUI

struct CounterRowView: View {
    
    let taskName: String
    let taskCount: Int
    let gold = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)
    
    var body: some View {
        HStack {
            Text(taskName)
            Spacer()
            Text(String(taskCount))
            Image(systemName: "checkmark.seal")
        }
        .ignoresSafeArea()
        .foregroundColor(Color(uiColor: gold))
    }
}
