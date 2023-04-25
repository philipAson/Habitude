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
    let dateHandler = DateHandlerVM()
    
    @Published var tasks = [Task]()
    @Published var plannedDays = [Day]()
    
    // !!! LISTENER !!!
    
    func listenToFirestore() {
        guard let user = auth.currentUser else {return}
        
        let userTasks = db.collection("users").document(user.uid).collection("tasks")
        let userPlannedDays = db.collection("users").document(user.uid).collection("plannedDays")
        
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
        
        userPlannedDays.addSnapshotListener() {
            snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("error fetching doc \(err)")
            } else {
                self.plannedDays.removeAll()
                
                for document in snapshot.documents {
                    
                    do{
                        let day = try document.data(as : Day.self)
                        
                        self.plannedDays.append(day)
                        
                    } catch {
                        print("error reading DB")
                    }
                }
            }

        }
    }
    //-------------------------------------------------------------------------------------------------------------

    
    // !!! TASK HANDLING !!!
    
    func saveTaskToFirestore(task : Task) {
        guard let user = auth.currentUser else {return}
        let userTasks = db.collection("users").document(user.uid).collection("tasks")
        
        do {
            try userTasks.addDocument(from: task)
        } catch {
            print("error saving task to firestore")
        }
    }

    func loadTasksforThis(day : Date) -> [Task] {
        var todaysTasks : [Task] = []
        let choosenDay = dateHandler.setDayOfWeek(date: day)
        
        for task in tasks {
            if task.weekDays.contains(choosenDay){
                todaysTasks.append(task)
            }
        }
        
        return todaysTasks
    }
    //-------------------------------------------------------------------------------------------------------------
    
    
    // !!! DAY HANDLING !!!

    func saveDayToFirestore(day : Day) {
        guard let user = auth.currentUser else {return}
        let userPlannedDays = db.collection("users").document(user.uid).collection("plannedDays")
        
        do {
            try userPlannedDays.addDocument(from: day)
        } catch {
            print("error saving task to firestore")
        }
    }
    
    func loadPlannedTasksForThis(choosenDay : Date) -> [Task] {
        var plannedTasks : [Task] = []
        
        for day in plannedDays {
            if format(date: day.date) == format(date: choosenDay){
                plannedTasks = day.tasks
            }
        }
        
        return plannedTasks
    }
    
    func format(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd"
        return dateFormatter.string(from: date)
    }
}

