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
    // getter for day of week -> String
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
    // setter for day of week based of Date->Func->String!
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
    // getter for week of year -> Int
    func getWeekOfYear() -> Int {
        return calendar.component(.weekOfYear, from: date) // Get the week of the year component from the date object
    }
    // setter for week of year Date->func->Int
    func setWeekOfYear(date : Date) -> Int {
        return calendar.component(.weekOfYear, from: date)
    }
    
    func getDateOfXdaysFromNow(x : Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: +x, to: Date())!
    }
    func getDateOfXdaysBeforeNow(x : Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -x, to: Date())!
    }
}
