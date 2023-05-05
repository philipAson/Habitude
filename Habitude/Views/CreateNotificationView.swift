//
//  CreateNotificationView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-05-05.
//

import SwiftUI

struct CreateNotificationView: View {
    @ObservedObject var notificationVM : NotificationVM
    @State private var title = ""
    @State private var date = Date()
    @Binding var isPresented : Bool
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    HStack {
                        TextField("Notification title", text: $title)
                        Spacer()
                        DatePicker("", selection: $date)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color(.white))
                    .cornerRadius(5)
                    
                    Button {
                        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
                        guard let day = dateComponents.day, let month = dateComponents.month, let year = dateComponents.year, let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
                        notificationVM.createLocalNotification(title: title, day: day, month: month, year: year, hour: hour, minute: minute) { error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                }
                            }
                        }
                    } label: {
                        Text("Create")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onDisappear {
            notificationVM.reloadLocalNotifications()
        }
        .navigationTitle("Create")
        .navigationBarItems(trailing: Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .imageScale(.large)
        })
    }
}

struct CreateNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNotificationView(
            notificationVM: NotificationVM(),
            isPresented: .constant(false)
        )
    }
}
