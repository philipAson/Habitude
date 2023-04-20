//
//  DateHandlerVC.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-20.
//

import Foundation

struct DateHandlerVC {
    
    private let date = Date()
    private let calendar : Calendar = Calendar.current
    
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
    
    func getWeekOfYear() -> Int {
        return calendar.component(.weekOfYear, from: date)
    }
    
}
