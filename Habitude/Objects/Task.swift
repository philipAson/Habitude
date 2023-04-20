//
//  Task.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-19.
//

import Foundation
import FirebaseFirestoreSwift

struct Task : Codable {
    
    @DocumentID var id : String?
    
    var name : String
    var weekDays : [String]
    var color : String
    var isReturningTask : Bool
}
