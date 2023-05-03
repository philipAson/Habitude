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
    
    let db = Firestore.firestore()
    let dateHandler = DateHandlerVM()
    
    @StateObject var userData = UserDataVM()
    @State var tasks : [Task] = []
    @State var today = Date.now
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("w.\(dateHandler.getWeekOfYear())")
                    .bold()
                    .padding()
                    .font(.title3)
                Text(dateHandler.getDayOfWeek())
                    .bold()
                    .padding()
                    .font(.title)
                Spacer()
                List() {
                    Section("Planned") {
                        ForEach(userData.loadPlannedTasksForThis(choosenDay: today), id: \.self) { task in
                            RowView(task: task)
                                .onTapGesture(count: 2) {
                                    //addTaskToTasksDone
                                    // Not Working!!!
//                                    userData.addTaskToTasksDone(task: task, date: today)
                                    print("farcturedButWhole")
                                }
                        }
                    }
                    Section("Reoccurring") {
                        ForEach(userData.loadTasksforThis(day: today)) { task in
                            RowView(task: task)
                                .onTapGesture(count: 2) {
                                    //addTaskToTasksDone
                                    print("jodåSåAttEeeeh")
                                }
                        }
                    }
                }
            }
            .navigationBarItems(trailing: NavigationLink(destination: AddTaskToTasksView(dayToAddTo: $today)) {
                    Image(systemName: "text.badge.plus")
            })
        }
        .onAppear() {
            userData.listenToFirestore()
            
            
            // MOCK DATA !!! DELETE EV !!!
            
//            let köpPresentTillBibbi = Task(name: "köp present till bibbi", weekDays: [], color: "orange")
//            let köphundmat = Task(name: "köp hundmat", weekDays: [], color: "mint")
//            var thursday = Day(date: today)
//            thursday.tasks.append(köpPresentTillBibbi)
//            thursday.tasks.append(köphundmat)
//            userData.saveDayToFirestore(day: thursday)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
