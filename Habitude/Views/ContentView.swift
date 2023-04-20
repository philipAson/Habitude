//
//  ContentView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-18.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @StateObject var userData = UserDataVM()
    @State var signedIn : Bool = false
    @State var tasks = [Task]()
    
    let db = Firestore.firestore()
    let dateHandler = DateHandlerVM()
    
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
                    ForEach(userData.tasks) { task in
                
                        RowView(task: task, userData: userData)
                        
                    }
                }.navigationTitle("Tasks")
            }
            
            
        }.onAppear() {
            userData.listenToFirestore()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
