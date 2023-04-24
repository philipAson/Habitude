//
//  CreateTaskView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-23.
//

import SwiftUI

struct CreateTaskView: View {
    
    @State var taskName : String = ""
    @State var taskIsReturning : Bool = false
    @State var weekdays: [String] = ["Monday", "Tuesday", "Wednsday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State var daysSelected: [String] = []
    @State var choosenColor : String = ""
    
    let colors: [String: Color] = ["orange": .orange, "teal": .teal, "cyan": .cyan, "mint": .mint, "blue": .blue, "black": .black]
    
    var body: some View {
        VStack{
            Text("Create a task")
                .padding()
                .font(.largeTitle)
                .bold()
            TextField("Name", text: $taskName)
                .padding()
            Toggle(isOn: $taskIsReturning) {
                Text("Returning Task")
                
                if taskIsReturning {
                    List {
                        
                        ForEach(self.weekdays, id: \.self) { day in
                            MultipleSelectionRow(title: "\(day)'s", isSelected: self.daysSelected.contains(day)) {
                                if self.daysSelected.contains(day) {
                                    self.daysSelected.removeAll(where: { $0 == day})
                                } else {
                                    self.daysSelected.append(day)
                                }
                            }
                        }
                    }
                }
            }
            .onChange(of: taskIsReturning) { value in
                if !value {
                    daysSelected.removeAll()
                }
            }
            .padding()
            Picker("Please choose a color", selection: $choosenColor) {
                ForEach(colors.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    Text(key)
                        .accentColor(.blue)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
            
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
