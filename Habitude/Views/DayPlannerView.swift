//
//  DayPlannerView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-23.
//

import SwiftUI

struct DayPlannerView: View {
    
    @State var dateToPlan : Date = Date()
    
    let fiveYearsFromNow = Calendar.current.date(byAdding: .year, value: +10, to: Date())
    
    @StateObject var userData = UserDataVM()
    
    var body: some View {
        
        VStack {
            DatePicker(selection: $dateToPlan, in : Date()...fiveYearsFromNow!, displayedComponents: .date) {
                Text("Select a date")
            }
            .padding()
            
            List() {
                ForEach(userData.loadTasksforThis(day: dateToPlan)) { task in
                    RowView(task: task, userData: userData)
                }
            }

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
