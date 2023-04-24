//
//  DayPlannerView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-23.
//

import SwiftUI

struct DayPlannerView: View {
    
    @State private var today = Date.now
    
    @StateObject var userData = UserDataVM()
    
    var body: some View {
        VStack {
            DatePicker(selection: $today, in : ...Date.now, displayedComponents: .date) {
                Text("Select a date")
            }
            Text("skit")
            List() {
                ForEach(userData.tasks) { task in
                    RowView(task: task, userData: userData)
                }
                
            }
        }.onAppear() {
            userData.listenToFirestore()
        }
        
    }
}

struct DayPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        DayPlannerView()
    }
}
