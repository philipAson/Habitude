//
//  AddTaskToTasksView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-26.
//

import SwiftUI

struct AddTaskToTasksView: View {
    
    @StateObject var userData = UserDataVM()
    @State var tasksToAdd : [Task] = []
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        NavigationView {
            List {
                Section("add these") {
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
                    userData.addToDay(date: Date.now, tasks: tasksToAdd)
                    presentationMode.wrappedValue.dismiss()
                })
            {
                Image(systemName: "square.and.arrow.down")
            }
        )
    }
}

struct AddTaskToTasksView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskToTasksView()
    }
}
