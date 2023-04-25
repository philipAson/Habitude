//
//  Day.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-19.
//

import Foundation
import FirebaseFirestoreSwift

struct Day : Codable, Identifiable {
    
    @DocumentID var id : String?
    
    var weekday : String
    var date : Date
    var tasks : [Task] = []
    var tasksDone : [Task] = []
    var perfectDay : Bool
    
}
