//
//  AddTaskToTasksView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-26.
//

import SwiftUI

struct AddTaskToTasksView: View {
    
    @StateObject var userData = UserDataVM()
    @State var dateHandler = DateHandlerVM()
    @State var tasksToAdd : [Task] = []
    @State var saveButtonTapped = false
    
    @Binding var dayToAddTo : Date
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        NavigationView {
            List {
                Section("add these to: \(dateHandler.setDayOfWeek(date: dayToAddTo)): w.\(dateHandler.setWeekOfYear(date: dayToAddTo))") {
                    ForEach(tasksToAdd) { task in
                        RowView(task: task)
                    }
                }
                Section("Tasks") {
                    ForEach(userData.tasks) { task in
                        RowView(task: task)
                            .onTapGesture(count: 2, perform: {
                                if let index = userData.tasks.firstIndex(of: task) {
                                    userData.tasks.remove(at: index)
                                    tasksToAdd.append(task)
                                }
                                
                            })
                    }
                }
            }.onAppear() {
                userData.listenToFirestore()
            }
        }.navigationBarItems(
            trailing:
                Button(action: {
                    userData.addToDay(date: dayToAddTo, tasks: tasksToAdd)
                    presentationMode.wrappedValue.dismiss()
                    self.saveButtonTapped.toggle()
                })
            {
                Image(systemName: "square.and.arrow.down")
            }
            .disabled(saveButtonTapped)
        )
    }
}

//struct AddTaskToTasksView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskToTasksView(dayToAddTo: Date())
//    }
//}
