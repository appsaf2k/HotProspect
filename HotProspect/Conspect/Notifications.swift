//
//  Notifications.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Локальные уведомления для пользователя



import SwiftUI
import UserNotifications

struct Notifications: View {
    var body: some View {
        VStack {
            Button("Request permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("success")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Shedule Notifications") {
                let content = UNMutableNotificationContent()
                content.title = "Pokormi KOTA"
                content.subtitle = "Eta TBAPb u)I(e 3ae6aJIa"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            } .padding()
        }
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
