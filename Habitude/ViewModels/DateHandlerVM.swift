//
//  DateHandlerVM.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-20.
//

import SwiftUI
import UIKit
import Foundation

struct DateHandlerVM {
    
    private let date = Date() // Create a new date object for the current date and time
    private let calendar : Calendar = Calendar.current // Get the current calendar
    
    @State var xDate = Date()
    
    func getDayOfWeek() -> String {
        
        let weekday = calendar.component(.weekday, from: date)
        switch weekday {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednsday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Invalid weekday"
            
        }
    }
    
    func setDayOfWeek(date : Date) -> String {
        
        let weekday = calendar.component(.weekday, from: date)
        switch weekday {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednsday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Invalid weekday"
            
        }
    }
    
    func getWeekOfYear() -> Int {
        return calendar.component(.weekOfYear, from: date) // Get the week of the year component from the date object
    }
    
    func setWeekOfYear(date : Date) -> Int {
        return calendar.component(.weekOfYear, from: date)
    }
    
    func getXdaysFromNow(x : Int) -> Date {
        // FRÅGA DAVID (IF-LET ELLER GUARD?)
        return Calendar.current.date(byAdding: .day, value: +x, to: Date())!
    }
    
//    func loadTasksforThis(day : Date) -> [Task] {
//        var todaysTasks : [Task] = []
//        let choosenDay = setDayOfWeek(date: day)
//
//        for task in userdata.tasks {
//            if task.weekDays.contains(choosenDay){
//                todaysTasks.append(task)
//            }
//        }
//
//        return todaysTasks
//    }
    
}
