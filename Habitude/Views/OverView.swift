//
//  OverView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-05-04.
//

import SwiftUI

struct OverView: View {
    
    let userData = UserDataVM()
    let dateHandler = DateHandlerVM()
    let gold = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)
    
    @State var from: Date = DateHandlerVM().getDateOfXdaysBeforeNow(x: 14)
    @State var to: Date = DateHandlerVM().getDateOfXdaysFromNow(x: 14)
    
    var body: some View {
        VStack {
            Spacer()
            Text("check the statistics bruv")
                .font(.title.bold())
                .padding()
                .foregroundColor(.init(uiColor: gold))
            DatePicker("from", selection: $from, in: dateHandler.getDateOfXdaysBeforeNow(x: 360)...dateHandler.getDateOfXdaysFromNow(x: 360), displayedComponents: .date)
                .padding()
                .font(.title2.bold())
            DatePicker("to", selection: $to, in: dateHandler.getDateOfXdaysBeforeNow(x: 360)...dateHandler.getDateOfXdaysFromNow(x: 360), displayedComponents: .date)
                .padding()
                .font(.title2.bold())
            List(userData.loadAllTasksDone(from: from, to: to).map { taskName, count in
                CounterRowView(taskName: taskName, taskCount: count)
            }.sorted(by: { $0.taskCount > $1.taskCount }), id: \.taskName) { taskRow in
                taskRow
            }
        }
        .onAppear() {
            userData.listenToFirestore()
        }
    }
}
