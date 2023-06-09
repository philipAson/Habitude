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
    
    var date : Date
    var tasks : [Task] = []
    var tasksDone : [Task] = []
    var dateFormatted : String
    
    init(date: Date) {
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd"
        self.dateFormatted = dateFormatter.string(from: date)
    }
}
