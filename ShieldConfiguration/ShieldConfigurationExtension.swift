//
//  ShieldConfigurationExtension.swift
//  ShieldConfiguration
//
//  Created by Dante Kim on 10/19/23.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsChanged), name: UserDefaults.didChangeNotification, object: nil)

            // get shared local storage across extensions
            let sharedDefaults = UserDefaults(suiteName: "group.io.nora.changeshield")

            // get the shield mode
            let shieldMode = sharedDefaults?.bool(forKey: "doxoshieldmode") ?? false

            // get the today focus set from morning journal
            let todayFocus = sharedDefaults?.string(forKey: "todayFocus")
            let todayFocusDateSet = sharedDefaults?.string(forKey: "todayFocusDateSet")

            // reset shield mode to default
            sharedDefaults?.set("default", forKey: "doxoshieldmode")

            // get today date as yyyy-MM-dd
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let today = formatter.string(from: date)
            
            let focusTitle = todayFocusDateSet == today ? "Today's Focus: \(todayFocus ?? "None")" : "Life is short2."
            
            // Determine the title based on the shield mode
            let titleText: String
            if shieldMode {
                titleText = "Sent Notification!"
                sharedDefaults?.set(false, forKey: "doxoshieldmode")

                // Save changes (this is often not necessary as UserDefaults saves automatically, but it's good for immediate persistence)
                sharedDefaults?.synchronize()
            } else {
                titleText = focusTitle
            }
        // Customize the shield as needed for applications.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.systemMaterialLight,
            backgroundColor: UIColor(red: 0.71, green: 0.66, blue: 0.98, alpha: 1.00),
          icon: UIImage(named: "mainHalo"),
          title: ShieldConfiguration.Label(text: titleText, color: .black),
            subtitle: ShieldConfiguration.Label(text: shieldMode ? "Sent Notification!" :  "If you want to use this app, click break & check your notifications for Doxo (permission needs to be enabled).", color: .black),
          primaryButtonLabel: ShieldConfiguration.Label(text: "Close App", color: .white),
          primaryButtonBackgroundColor: UIColor.black,
          secondaryButtonLabel: ShieldConfiguration.Label(text: "Take a Break", color: .black)
        )
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsChanged), name: UserDefaults.didChangeNotification, object: nil)

            // get shared local storage across extensions
            let sharedDefaults = UserDefaults(suiteName: "group.io.nora.changeshield")

            // get the shield mode
            let shieldMode = sharedDefaults?.bool(forKey: "doxoshieldmode") ?? false

            // get the today focus set from morning journal
            let todayFocus = sharedDefaults?.string(forKey: "todayFocus")
            let todayFocusDateSet = sharedDefaults?.string(forKey: "todayFocusDateSet")

            // reset shield mode to default
            sharedDefaults?.set("default", forKey: "doxoshieldmode")

            // get today date as yyyy-MM-dd
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let today = formatter.string(from: date)
            
            let focusTitle = todayFocusDateSet == today ? "Today's Focus: \(todayFocus ?? "None")" : "Life is short2."
            
            // Determine the title based on the shield mode
            let titleText: String
            if shieldMode {
                titleText = "Sent Notification1!"
                sharedDefaults?.set(false, forKey: "doxoshieldmode")

                // Save changes (this is often not necessary as UserDefaults saves automatically, but it's good for immediate persistence)
                sharedDefaults?.synchronize()
            } else {
                titleText = focusTitle
            }

        
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.systemMaterialLight,
            backgroundColor: UIColor(red: 0.71, green: 0.66, blue: 0.98, alpha: 1.00),
          icon: UIImage(named: "mainHalo"),
          title: ShieldConfiguration.Label(text: titleText, color: .black),
            subtitle: ShieldConfiguration.Label(text: shieldMode ? "Sent Notification1!" :  "If you want to use this app, click break & check your notifications for Doxo (permission needs to be enabled).", color: .black),
          primaryButtonLabel: ShieldConfiguration.Label(text: "Close App", color: .white),
          primaryButtonBackgroundColor: UIColor.black,
          secondaryButtonLabel: ShieldConfiguration.Label(text: "Take a Break", color: .black)
        )
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.systemMaterialLight,
            backgroundColor: UIColor(red: 0.71, green: 0.66, blue: 0.98, alpha: 1.00),
          icon: UIImage(named: "mainHalo"),
          title: ShieldConfiguration.Label(text: "Life is short.", color: .black),
          subtitle: ShieldConfiguration.Label(text: "If you want to use this app, click break & check your notifications for Doxo (permission needs to be enabled).", color: .black),
          primaryButtonLabel: ShieldConfiguration.Label(text: "Close App", color: .white),
          primaryButtonBackgroundColor: UIColor.black,
          secondaryButtonLabel: ShieldConfiguration.Label(text: "Take a Break", color: .black)
        )
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.systemMaterialLight,
            backgroundColor: UIColor(red: 0.71, green: 0.66, blue: 0.98, alpha: 1.00),
          icon: UIImage(named: "mainHalo"),
          title: ShieldConfiguration.Label(text: "Life is short.", color: .black),
          subtitle: ShieldConfiguration.Label(text: "If you want to use this app, click break & check your notifications for Doxo (permission needs to be enabled).", color: .black),
          primaryButtonLabel: ShieldConfiguration.Label(text: "Close App", color: .white),
          primaryButtonBackgroundColor: UIColor.black,
          secondaryButtonLabel: ShieldConfiguration.Label(text: "Take a Break", color: .black)
        )
    }
    
    @objc func userDefaultsChanged(notification: NSNotification)  {
        // Check the value in UserDefaults and update the UI accordingly
        
    }
}
