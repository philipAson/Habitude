//
//  UserDataVM.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-20.
//

import Foundation
import SwiftUI
import Firebase

class UserDataVM : ObservableObject {
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    @Published var tasks = [Task]()
    
    func saveTaskToFirestore(task : Task) {
        guard let user = auth.currentUser else {return}
        let userTasks = db.collection("users").document(user.uid).collection("tasks")
        
        do {
            try userTasks.addDocument(from: task)
        } catch {
            print("error saving task to firestore")
        }
    }

    func listenToFirestore() {
        guard let user = auth.currentUser else {return}
        let userTasks = db.collection("users").document(user.uid).collection("tasks")
        
        userTasks.addSnapshotListener() {
            snapshot, err in
            
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("error fetching doc \(err)")
            } else {
                self.tasks.removeAll()
                for document in snapshot.documents {
                    
                    do{
                        let task = try document.data(as : Task.self)
                        self.tasks.append(task)
                    } catch {
                        print("error reading DB")
                    }
                }
            }
        }
    }
    
    
}

