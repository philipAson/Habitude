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
    let dateHandler = DateHandlerVM()
    
    @StateObject var userData = UserDataVM()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("w.\(dateHandler.setWeekOfYear(date: dateToPlan))")
                    .bold()
                    .padding()
                    .font(.title3)
                Spacer()
                DatePicker(selection: $dateToPlan, in : Date()...fiveYearsFromNow!, displayedComponents: .date) {
                    Text(dateHandler.setDayOfWeek(date: dateToPlan))
                        .bold()
                        .padding()
                        .font(.title)}
                .datePickerStyle(.compact)
                .padding()
                // !!!! ADD MENU FOR TASKS TO ADD HERE !!!!
                
                List() {
                    Section("Planned") {
                        ForEach(userData.loadPlannedTasksForThis(choosenDay: dateToPlan)) { task in
                            RowView(task: task)
                        }
                    }
                    Section("Reoccurring") {
                        ForEach(userData.loadTasksforThis(day: dateToPlan)) { task in
                            RowView(task: task)
                        }
                    }
                }
            }.navigationBarItems(trailing: NavigationLink(destination: AddTaskToTasksView()) {
                Image(systemName: "text.badge.plus")
            })
            
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
