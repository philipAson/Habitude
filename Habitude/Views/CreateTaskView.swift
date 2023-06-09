//
//  CreateTaskView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-23.
//

import SwiftUI

struct CreateTaskView: View {
    
    @StateObject var userData = UserDataVM()
    
    @FocusState private var isFocused: Bool
    
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
                .focused(self.$isFocused)
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
            ScrollView(.horizontal) {
                HStack {
                    ForEach(colors.sorted(by: { $0.key < $1.key}), id: \.key) { key, value in
                        Circle()
                            .foregroundColor(value)
                            .frame(width: 45, height: 45)
                            .opacity(key == choosenColor ? 0.5 : 1.0)
                            .scaleEffect(key == choosenColor ? 1.1 : 1.0)
                            .onTapGesture {
                                choosenColor = key
                            }
                    }
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(45)
                .padding(.horizontal)
                Spacer()
            }
            Button {
                print($choosenColor)
                print($daysSelected)
                print($taskName)
                
                let newTask = Task(name: taskName, weekDays: daysSelected, color: choosenColor)
                userData.saveTaskToFirestore(task: newTask)
                
                taskIsReturning = false
                taskName = ""
            
            } label: {
                Image(systemName: "square.and.arrow.down")
                    .imageScale(.large)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(16)
            }
            Spacer()
        }
        .onAppear {
            self.isFocused = true
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
