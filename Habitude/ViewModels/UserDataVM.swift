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
        
        do {
            try db.collection("Tasks").addDocument(from: task)
        } catch {
            print("error saving task to firestore")
        }
    }

    func listenToFirestore() {
        db.collection("Tasks").addSnapshotListener() {
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

