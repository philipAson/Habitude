//
//  Task.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-19.
//

import Foundation
import FirebaseFirestoreSwift

// rör ej!!
struct Task : Codable, Identifiable, Equatable, Hashable {
    
    @DocumentID var id : String?
    
    var name : String
    var weekDays : [String]
    var color : String
}
