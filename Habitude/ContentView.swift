//
//  ContentView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-18.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var signedIn : Bool = false
    
    let db = Firestore.firestore()
    let dateHandler = DateHandlerVC()
    
    var body: some View {
        
        VStack {
            Text("w.\(dateHandler.getWeekOfYear())")
                .bold()
                .padding()
            Text(dateHandler.getDayOfWeek())
            Spacer()
            
            NavigationStack{
                List() {
                    ForEach(1...5, id: \.self) { index in
                
                        Text("Task")
                        
                    }
                }.navigationTitle("Tasks")
            }
            
            
        }.onAppear() {
//            db.collection("test").addDocument(data: ["task": "Code"])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
