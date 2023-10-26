//
//  AppDelegate.swift
//  Halo
//
//  Created by Dante Kim on 10/21/23.
//

import Foundation
import UIKit
import BackgroundTasks
import os.log

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            if response.notification.request.identifier == "breakTime" {
                NotificationCenter.default.post(name: NSNotification.Name("breakTime"), object: nil)
            } else if response.notification.request.identifier == "sharedDefaultsUpdated" {
                print("grrr")
            }
            completionHandler()
        }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("broom kid")
        UNUserNotificationCenter.current().delegate = self
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: "io.nora.halo.backgroundTask1")
        let bgTaskIdentifier = "io.nora.halo.backgroundTask1"
        BGTaskScheduler.shared.register(forTaskWithIdentifier: bgTaskIdentifier, using: nil) { task in
            os_log("registering finally", log: OSLog.default, type: .debug)
            print("registering finally please")
        }
        let request = BGAppRefreshTaskRequest(identifier: bgTaskIdentifier)
            request.earliestBeginDate = Date(timeIntervalSinceNow: 5) // e.g., fetch every 15 minutes

            do {
                try BGTaskScheduler.shared.submit(request)
                print("scheduled")
            } catch let error as NSError {
                print("Could not schedule app refresh: \(error), \(error.userInfo)")
            }
       
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // This line will display the notification as if the app was in the background (i.e., it will show the alert, play the sound, etc.)
        completionHandler([.alert, .sound, .badge])
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        print("handling app refresh")
        task.expirationHandler = {
            // This block is called when the task expired.
            // Cancel any outstanding operations.
            print("task expired")
        }

        // Call your actual refresh logic here.
        print("vroom kid")
        task.setTaskCompleted(success: true)

//        fetchData { result in
//            switch result {
//            case .success:
//                task.setTaskCompleted(success: true)
//            case .failure:
//                task.setTaskCompleted(success: false)
//            }
//        }
    }
    func fetchData(completion: @escaping (Result<Int, Error>) -> Void) {
        // Your data fetching logic here.
        print("fetching")
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            // Your background fetch logic here
            print("background refresh happening now")
            let hasNewContent = checkForNewContent()
            
            if hasNewContent {
                completionHandler(.newData)
            } else {
                completionHandler(.noData)
            }
        }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
            print("entering background")
        }
        
        func applicationWillEnterForeground(_ application: UIApplication) {
            print("entering foreground")
        }

    func checkForNewContent() -> Bool {
        // Replace this with your actual logic to check for new content or conditions.
        return Bool.random()
    }
}
