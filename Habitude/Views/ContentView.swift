//
//  ContentView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-18.
//

import SwiftUI
import Firebase

struct ContentView : View {
    
    @State var signedIn : Bool = false
    
    var body: some View {
        if !signedIn {
            SignInView(signedIn: $signedIn)
        } else {
            MainView()
        }
    }
}

struct SignInView : View {
    
    @Binding var signedIn : Bool
    
    var auth = Auth.auth()
    
    var body: some View {
        Button(action: {
            auth.signInAnonymously { result, error in
                if let _ = error {
                    print("error signing in")
                } else {
                    signedIn = true
                }
            }
        }) {
            Text("Sign In ")
        }
    }
}

struct ToDoView: View {
    
    let dateHandler = DateHandlerVM()
    let fiveYearsFromNow = Calendar.current.date(byAdding: .year, value: +10, to: Date())
    
    @StateObject var userData = UserDataVM()
    
    @State var tasks : [Task] = []
    @State var choosenDate : Date = Date()
    @State var isNotificationPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("w.\(dateHandler.setWeekOfYear(date: choosenDate))")
                    .bold()
                    .padding()
                    .font(.title3)
                Spacer()
                DatePicker(selection: $choosenDate, in : Date()...fiveYearsFromNow!, displayedComponents: .date) {
                    Text(dateHandler.setDayOfWeek(date: choosenDate))
                        .bold()
                        .padding()
                        .font(.title)}
                .datePickerStyle(.compact)
                .padding()
                List() {
                    Section("Done") {
                        ForEach(userData.loadTasksDoneForThis(choosenDay: choosenDate), id: \.self) { task in
                            TasksDoneRowView(task: task)
                        }
                    }
                    Section("Planned") {
                        ForEach(userData.loadPlannedTasksForThis(choosenDay: choosenDate), id: \.self) { task in
                            RowView(task: task)
                                .onTapGesture(count: 2) {
                                    userData.addTaskToTasksDone(date: choosenDate, taskDone: task)
                                }
                                .onLongPressGesture{
                                    isNotificationPresented.toggle()
                                    print(isNotificationPresented)
                                }
                        }
                    }
                    Section("Reoccurring") {
                        ForEach(userData.loadTasksforThis(day: choosenDate)) { task in
                            RowView(task: task)
                                .onTapGesture(count: 2) {
                                    userData.addTaskToTasksDone(date: choosenDate, taskDone: task)
                                }
                        }
                    }
                }
                NavigationLink("", destination: NotificationListView(), isActive: $isNotificationPresented)
            }
            .navigationBarItems(trailing: NavigationLink(destination: AddTaskToTasksView(dayToAddTo: $choosenDate)) {
                    Image(systemName: "text.badge.plus")
            })
            .navigationBarItems(leading: NavigationLink(destination:
                CreateTaskView()) {
                    Image(systemName: "plus.circle")
            })
        }
        .onAppear() {
            userData.listenToFirestore()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
