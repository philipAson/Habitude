//
//  EditTasksView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-05-04.
//

import SwiftUI

struct EditTasksView: View {
    @ObservedObject var userData = UserDataVM()
    
    var body: some View {
        VStack{
            Text("Edit Tasks")
                .font(.title.bold())
                .padding()
            List() {
                ForEach(userData.tasks) { task in
                    RowView(task: task)
                        .onLongPressGesture {
                            print("GoTo -> Edit this (Task)")
                        }
                }
            }
        }.onAppear() {
            userData.listenToFirestore()
        }
    }
}

struct EditTasksView_Previews: PreviewProvider {
    static var previews: some View {
        EditTasksView()
    }
}
