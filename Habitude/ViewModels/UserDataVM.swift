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
    @Published var day = Date()
    
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
        let thisDay = format(date: day)
        // load all tasks to todaysTasks that has choosenDay as property
        for task in tasks {
            if task.weekDays.contains(choosenDay){
                todaysTasks.append(task)
            }
        }
        
        for day in plannedDays {
            // if day exists in db to this.
            if day.dateFormatted == thisDay {
                // now remove any tasks in todaysTasks that has alreaddy been done for that Day object
                for task in day.tasksDone {
                    todaysTasks.removeAll(where: {$0.name == task.name})
                }
            }
        }
        
        return todaysTasks
    }
    
    func loadPlannedTasksForThis(choosenDay : Date) -> [Task] {
        var plannedTasks : [Task] = []
        
        for day in plannedDays {
            if format(date: day.date) == format(date: choosenDay){
                plannedTasks.append(contentsOf: day.self.tasks)
            }
        }
        
        return plannedTasks
    }
    
    func loadTasksDoneForThis(choosenDay : Date) -> [Task] {
        var tasksDone : [Task] = []
        
        for day in plannedDays {
            if format(date: day.date) == format(date: choosenDay){
                tasksDone.append(contentsOf: day.self.tasksDone)
            }
        }
        
        return tasksDone
    }

    func addTaskToTasksDone(date: Date, taskDone: Task) {
        
        guard let user = auth.currentUser else {return}
        let thisDay = format(date: date)
        let dayRef = db.collection("users").document(user.uid).collection("plannedDays")
        let query = dayRef.whereField("dateFormatted", isEqualTo: thisDay)
        
        var dayExistsInDb = false
        for day in plannedDays {
            // if a Day object exists in db to this
            if day.dateFormatted == thisDay {
                
                dayExistsInDb = true
                
                query.getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                        return
                    }
                    
                    guard let snapshot = snapshot else { return }

                    
                    for document in snapshot.documents {
                        var day = try? document.data(as: Day.self)
                        day?.tasksDone.append(taskDone)
                        day?.tasks.removeAll(where: {$0.name == taskDone.name})
                        
                        do {
                            try document.reference.setData(from: day)
                            print("Task added to day.tasksDone successfully.")
                        } catch let error {
                            print("Error writing day to Firestore: \(error)")
                        }
                    }
                }
            }
        }
        // else create a new one in db with these properties
        if dayExistsInDb == false {
            var newDay = Day(date: date)
            newDay.tasksDone.append(taskDone)
            saveDayToFirestore(day: newDay)
        }
    }
    
    func addToDay(date: Date, tasks: [Task]) {
        
        guard let user = auth.currentUser else {return}
        let thisDay = format(date: date)
        let dayRef = db.collection("users").document(user.uid).collection("plannedDays")
        let query = dayRef.whereField("dateFormatted", isEqualTo: thisDay)
        
        var dayExistsInDb = false
        for day in plannedDays {
            // if a day object exists in db to this
            if day.dateFormatted == thisDay {
                
                dayExistsInDb = true
                
                query.getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                        return
                    }
                    
                    guard let snapshot = snapshot else { return }
                    
                    for document in snapshot.documents {
                        var day = try? document.data(as: Day.self)
                        day?.tasks.append(contentsOf: tasks)
                        
                        do {
                            try document.reference.setData(from: day)
                            print("Task added to day.tasks successfully.")
                        } catch let error {
                            print("Error writing day to Firestore: \(error)")
                        }
                    }
                }
            }
        }
        // else create a new one in db with these properties
        if dayExistsInDb == false {
            var newDay = Day(date: date)
            newDay.tasks.append(contentsOf: tasks)
            saveDayToFirestore(day: newDay)
        }
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
    
    func format(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    func loadAllTasksDone(from : Date, to : Date) -> [String: Int] {
        
        var taskCount : [String: Int] = [:]
            
        for day in plannedDays{
            // for Day object in DateRange
            if day.date >= from && day.date <= to {
                for task in day.tasksDone{
                    // adding one to the (counter if it itterates over a Task Object with the same name
                    if let count = taskCount[task.name] {
                        taskCount[task.name] = count + 1
                    } else {
                        taskCount[task.name] = 1
                    }
                }
            }
        }
        
        return taskCount
    }
}

