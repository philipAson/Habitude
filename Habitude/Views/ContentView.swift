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
    
    @State var showingCreateTaskAlert = false
    @State var showingListOfTasks = false
   
    let today = Date()
    let dayAfterTomorrow = DateHandlerVM().getXdaysFromNow(x: 2)
    
    
    var body: some View {
        
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
            
            NavigationStack{
                List() {
                    Section("Today") {
                        ForEach(userData.loadTasksforThis(day: today)) { task in
                    
                            RowView(task: task, userData: userData)
                            
                        }
                    }
                    .font(.title2.bold())
                    Section("Tomorrow") {
                        ForEach(userData.loadTasksforThis(day: dateHandler.getXdaysFromNow(x: 1))) { task in
                    
                            RowView(task: task, userData: userData)
                            
                        }
                    }
                    Section(dateHandler.setDayOfWeek(date: dayAfterTomorrow)) {
                        ForEach(userData.loadTasksforThis(day: dateHandler.getXdaysFromNow(x: 2))) { task in
                    
                            RowView(task: task, userData: userData)
                            
                        }
                    }
                }
            }
        }.onAppear() {
            userData.listenToFirestore()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
