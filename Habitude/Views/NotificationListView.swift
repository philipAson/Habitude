//
//  NotificationListView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-05-05.
//

import SwiftUI

struct NotificationListView: View {
    
    @StateObject private var notificationVM = NotificationVM()
    
    @State private var isCreatePresented = false
    
    var body: some View {
        List(notificationVM.notifications, id: \.identifier) { notification in
            Text(notification.content.title)
                .fontWeight(.semibold)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Notifications")
        .onAppear(perform: notificationVM.reloadAuthorizationStatus)
        .onChange(of: notificationVM.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                notificationVM.requestAuth()
            case .authorized:
                notificationVM.reloadLocalNotifications()
            default:
                break
            }
        }
        .navigationBarItems(trailing: Button {
            isCreatePresented = true
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .navigationBarItems(trailing: Button {
            notificationVM.clearAllNotifications()
        } label: {
            Image(systemName: "minus.circle")
                .imageScale(.large)
        })
        .sheet(isPresented: $isCreatePresented) {
            NavigationView {
                CreateNotificationView(
                    notificationVM: notificationVM,
                    isPresented: $isCreatePresented
                )
            }
            .accentColor(.primary)
        }
    }
}

struct NotificationListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
