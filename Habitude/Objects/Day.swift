//
//  Day.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-19.
//

import Foundation

struct Day {
    
    let weekday : String
    let date : Date
    var tasks : [Task] = []
    var tasksDone : [Task] = []
    var perfectDay : Bool
    
}
