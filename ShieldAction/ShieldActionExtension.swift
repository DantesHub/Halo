//
//  ShieldActionExtension.swift
//  customshield
//
//  Created by Teju Sharma on 7/21/23.
//

import ManagedSettings
import UserNotifications
import SwiftUI
import UIKit
import SceneKit


// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
    
    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        
        let store = ManagedSettingsStore()
        
        switch action {
        case .primaryButtonPressed:
            completionHandler(.close)
        case .secondaryButtonPressed:
            let sharedDefaults = UserDefaults.init(suiteName: "group.doxomonitoring")
            
            // set doxoshieldmode to sentNotification
            sharedDefaults?.set("sentNotification", forKey: "doxoshieldmode")
            
            
//            store.shield.applications?.remove(application)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
//                store.shield.applications?.insert(application)
//            }
            
            
           // UserDefaults.standard.set(application, forKey: "currentShieldApplication")
            //UserDefaults.standard.set("Hello", forKey: "currentShieldApplication")
            //let userName = UserDefaults.standard.string(forKey: "username")
            
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                    
                    let content = UNMutableNotificationContent()
                    //content.title = "App Access "+(application.hashValue.description ?? "") //+(store.application.blockedApplications?.count.description ?? "N/A")
                    content.title = "From Doxo"
                    content.subtitle = "Remember to take a deep beep3..."
                    content.sound = UNNotificationSound.default
                    // content.userInfo = ["fromWhere": application.hashValue] as [String : Int]
                    
                    // Application(token: application).bundleIdentifier
                    
                    // content.setValue("Shield", forKey: "fromWhere")
                    // content.setValue(application, forKey: "currentApplication")
                    
                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    
                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request){ (error : Error?) in
                        if let theError = error {
                            // Handle any errors
                            
                            print("THERE WAS AN ERROR!!")
                            
                            
                            let content = UNMutableNotificationContent()
                            content.title = "App Access Error"
                            content.subtitle = "Application access => "+theError.localizedDescription
                            content.sound = UNNotificationSound.default
                            
                            //content.setValue("Shield", forKey: "fromWhere")
                            //content.setValue(application, forKey: "currentApplication")
                            
                            // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            
                            // choose a random identifier
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                        }
                   }
                    
                    
                    
                }
                else if !success {
                }
            else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
//            NavigationLink {
//                TimerOptions()
//            } label: {
//
//            }
            
            // completionHandler(.close)
            completionHandler(.defer)
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        let store = ManagedSettingsStore()
        switch action {
        case .primaryButtonPressed:
            completionHandler(.close)
        case .secondaryButtonPressed:
//            store.shield.applications?.remove(application)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
//                store.shield.applications?.insert(application)
//            }
           // UserDefaults.standard.set(application, forKey: "currentShieldApplication")
            //UserDefaults.standard.set("Hello", forKey: "currentShieldApplication")
            //let userName = UserDefaults.standard.string(forKey: "username")
            
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                    
                    let content = UNMutableNotificationContent()
                    //content.title = "App Access "+(application.hashValue.description ?? "") //+(store.application.blockedApplications?.count.description ?? "N/A")
                    content.title = "From Doxo"
                    content.subtitle = "Remember to take a deep beep1..."
                    content.sound = UNNotificationSound.default
                    // content.userInfo = ["fromWhere": application.hashValue] as [String : Int]
                    
                    // Application(token: application).bundleIdentifier
                    
                    // content.setValue("Shield", forKey: "fromWhere")
                    // content.setValue(application, forKey: "currentApplication")
                    
                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    
                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    //UNUserNotificationCenter.current().setValue(application, forKey: "currentApplication")
                    
//                    // Define the custom actions.
//                    let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
//                          title: "Accept",
//                          options: [])
//                    let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
//                          title: "Decline",
//                          options: [])
//                    // Define the notification type
//                    let meetingInviteCategory =
//                          UNNotificationCategory(
//                            identifier: "MEETING_INVITATION",
//                            actions: [acceptAction, declineAction],
//                            intentIdentifiers: [],
//                            hiddenPreviewsBodyPlaceholder: "",
//                            options: .customDismissAction
//                          )
//
//                    UNUserNotificationCenter.current().setNotificationCategories([meetingInviteCategory])
                    
                    // add our notification request
                    UNUserNotificationCenter.current().add(request){ (error : Error?) in
                        if let theError = error {
                            // Handle any errors
                            
                            print("THERE WAS AN ERROR!!")
                            
                            
                            let content = UNMutableNotificationContent()
                            content.title = "App Access Error"
                            content.subtitle = "Application access => "+theError.localizedDescription
                            content.sound = UNNotificationSound.default
                            
                            //content.setValue("Shield", forKey: "fromWhere")
                            //content.setValue(application, forKey: "currentApplication")
                            
                            // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            
                            // choose a random identifier
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                        }
                   }
                }
                else if !success {
                }
            else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
//            NavigationLink {
//                TimerOptions()
//            } label: {
//
//            }
            
            // completionHandler(.close)
            completionHandler(.defer)
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        let store = ManagedSettingsStore()

        
//        let applicationLst = store.application.blockedApplications
//        var name = ""
//        for val in applicationLst!{
//            if(val.hashValue == application.hashValue){
//                name = val.localizedDisplayName ?? ""
//            }
//        }
        
        
        switch action {
        case .primaryButtonPressed:
            completionHandler(.close)
        case .secondaryButtonPressed:
            let sharedDefaults = UserDefaults(suiteName: "group.io.nora.changeshield")
            sharedDefaults?.set(true, forKey: "secondaryButtonPressed")
            sharedDefaults?.set(true, forKey: "doxoshieldmode")

            // Save changes (this is often not necessary as UserDefaults saves automatically, but it's good for immediate persistence)
            sharedDefaults?.synchronize()
            let notificationNameRaw = "io.nora.shieldconfig"
            let notificationName = CFNotificationName(notificationNameRaw as CFString)
            CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, nil, nil, true)
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                    
                    let content = UNMutableNotificationContent()
                    //content.title = "App Access "+(application.hashValue.description ?? "") //+(store.application.blockedApplications?.count.description ?? "N/A")
                    content.title = "From Doxo"
                    content.subtitle = "Remember to take a deep beep4..."
                    content.sound = UNNotificationSound.default
                    // content.userInfo = ["fromWhere": application.hashValue] as [String : Int]
                    
                    // Application(token: application).bundleIdentifier
                    
                    // content.setValue("Shield", forKey: "fromWhere")
                    // content.setValue(application, forKey: "currentApplication")
                    
                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    
                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: "breakTime", content: content, trigger: trigger)
                    
                    // add our notification request
                    UNUserNotificationCenter.current().add(request) { (error : Error?) in
                        if let theError = error {
                            // Handle any errors
                            
                            print("THERE WAS AN ERROR!!")
                            
                            
                            let content = UNMutableNotificationContent()
                            content.title = "App Access Error"
                            content.subtitle = "Application access => "+theError.localizedDescription
                            content.sound = UNNotificationSound.default
                            
                            //content.setValue("Shield", forKey: "fromWhere")
                            //content.setValue(application, forKey: "currentApplication")
                            
                            // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            
                            // choose a random identifier
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                        }
                   }
                    
                    
                    
                }
                else if !success {
                    
                }
            else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
//            NavigationLink {
//                TimerOptions()
//            } label: {
//
//            }
            
            // completionHandler(.close)
            completionHandler(.defer)
        @unknown default:
            fatalError()
        }
    }
    
}
