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
                .padding()
            Text(dateHandler.getDayOfWeek())
                .padding()
            
            List() {
                ForEach(1...5, id: \.self) { index in
            
                    Text("Task")
                    
                }
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
