//
//  NotificationVM.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-05-05.
//

import Foundation
import UserNotifications

final class NotificationVM: ObservableObject {
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current()
            .getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuth() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound])
        { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    func reloadLocalNotifications() {
        print("reload notifications")
        UNUserNotificationCenter.current()
            .getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    func createLocalNotification(title: String, day: Int, month: Int, year: Int, hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func clearAllNotifications() {
        notifications.removeAll()
    }
}
