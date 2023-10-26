//
//  NotificationHelper.swift
//  Halo
//
//  Created by Dante Kim on 10/25/23.
//

import Foundation
import SwiftUI

struct NotificationHelper {
    // Schedule Notification with weekly bases.
     static func scheduleNotification(at date: Date, weekDay: Int, title: String, subtitle: String = "Practice makes perfect, tend to your garden today.", isMindful: Bool = false) {
         let triggerWeekly = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date)

         let content = UNMutableNotificationContent()

         content.title = title
         content.body = subtitle

         content.sound = UNNotificationSound.default
         let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)

         // choose a random identifier
         let request = UNNotificationRequest(identifier: "", content: content, trigger: trigger)

         // add our notification request
         UNUserNotificationCenter.current().add(request)
     }
}
