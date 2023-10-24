//
//  FamilyModel.swift
//  Focusbyte
//
//  Created by Dante Kim on 5/22/23.
//
import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings


class FamilyViewModel: ObservableObject {
    static let shared = FamilyViewModel()
    let store = ManagedSettingsStore()
    
    @Published var title: String = ""
    @Published var appsCount: Int = 0
    @Published var categoriesCount: Int = 0

    private init() {
        // multiple limits
        // multiple schedules
        // one focus
    }
    func setAppCategoriesCount() {
        
    }
    func restoreBlockedApps() {
        let sharedDefaults = UserDefaults(suiteName: "group.io.nora.changeshield")
        print("restoring:" + title)
        // Restore apps
        var restoredApps: Set<ApplicationToken> = []
        if let blockedAppData = sharedDefaults?.data(forKey: title + "BlockedApps") {
            let decoder = JSONDecoder()
            if let decodedApps = try? decoder.decode([ApplicationToken].self, from: blockedAppData) {
                restoredApps = Set(decodedApps)
                appsCount = restoredApps.count
            }
        }
        
        // Restore categories
        var restoredCategories: Set<ActivityCategoryToken> = []
        if let blockedCategoryData = sharedDefaults?.data(forKey: title + "BlockedCategories") {
            let decoder = JSONDecoder()
            if let decodedCategoryTokens = try? decoder.decode([ActivityCategoryToken].self, from: blockedCategoryData) {
                restoredCategories = Set(decodedCategoryTokens)
                categoriesCount = restoredCategories.count
            }
        }
        
        // Initialize selectionToDiscourage with restored values
        selectionToDiscourage = FamilyActivitySelection()
        selectionToDiscourage.applicationTokens = restoredApps
        selectionToDiscourage.categoryTokens = restoredCategories
    }
    
//    var focusSelectionToDiscourage = FamilyActivitySelection() {
//        
//    }
    
    var selectionToDiscourage = FamilyActivitySelection() {
        willSet {
            let applications = newValue.applicationTokens
            let categories = newValue.categoryTokens
            
            if title == "focus" {
                store.shield.applications = applications.isEmpty ? nil : applications
                store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
            } else {
                // if schedule is right now or if user has surpassed their limit.
                // Or should i just make the limit starting now.
                // add up all of the applications time
            }
           
            
            // Save to UserDefaults
            let sharedDefaults = UserDefaults(suiteName: "group.io.nora.changeshield")
            let encoder = JSONEncoder()
            
            // Save apps
            if let encodedApps = try? encoder.encode(Array(applications)) {
                sharedDefaults?.set(encodedApps, forKey: title + "BlockedApps")
                appsCount = applications.count
                print("1. Saved apps to UserDefaults.")
            } else {
                print("Failed to encode apps.")
            }
            
            // Save categories
            if let encodedCategoryTokens = try? encoder.encode(Array(categories)) {
                sharedDefaults?.set(encodedCategoryTokens, forKey: title + "BlockedCategories")
                categoriesCount = categories.count
                print("2. Saved category tokens to UserDefaults.")
            } else {
                print("Failed to encode category tokens.")
            }
        }
    }

    

    func initiateMonitoring() {
        let schedule = DeviceActivitySchedule(intervalStart: DateComponents(hour: 0, minute: 0), intervalEnd: DateComponents(hour: 23, minute: 59), repeats: true, warningTime: nil)
        
        let center = DeviceActivityCenter()
        do {
            try center.startMonitoring(.daily, during: schedule)
        }
        catch {
            print ("Could not start monitoring \(error)")
        }
        
        store.dateAndTime.requireAutomaticDateAndTime = true
        store.account.lockAccounts = true
        store.passcode.lockPasscode = true
        store.siri.denySiri = true
        store.appStore.denyInAppPurchases = true
        store.appStore.maximumRating = 200
        store.appStore.requirePasswordForPurchases = true
        store.media.denyExplicitContent = true
        store.gameCenter.denyMultiplayerGaming = true
        store.media.denyMusicService = false
    }
    
    func unblockApps(minutes: Int) {
        let applicationLst = store.shield.applications
        let categoriesLst = store.shield.applicationCategories
        let webDomains = store.shield.webDomains
        let webDomainCategories = store.shield.webDomainCategories
        
        
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        store.shield.webDomains = nil
        store.shield.webDomainCategories = nil
        
        
        var timePassed = 0
        
        var timer: Timer?
        
        let seconds = minutes * 60
        
        // Timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] (t) in
            timePassed += 1
            if timePassed >= seconds {
                print("calling here")
                // Cancel the timer after blocking time elapsed
                
                // stop playing
                store.shield.applications = applicationLst
                store.shield.applicationCategories = categoriesLst
                store.shield.webDomains = webDomains
                store.shield.webDomainCategories = webDomainCategories
                
                timer?.invalidate()
                timer = nil
            }
        }
    }
}

extension DeviceActivityName {
    static let daily = Self("daily")
}
