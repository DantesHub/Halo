//
//  AppDelegate.swift
//  Halo
//
//  Created by Dante Kim on 10/21/23.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            print("didReceive")
            if response.notification.request.identifier == "breakTime" {
                NotificationCenter.default.post(name: NSNotification.Name("breakTime"), object: nil)
            }
            completionHandler()
        }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("setting delegate")
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // This line will display the notification as if the app was in the background (i.e., it will show the alert, play the sound, etc.)
        print("calling in the foreground")
        completionHandler([.alert, .sound, .badge])
    }
}
