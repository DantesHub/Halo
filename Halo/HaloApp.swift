//
//  HaloApp.swift
//  Halo
//
//  Created by Dante Kim on 8/26/23.
//

import SwiftUI
import BackgroundTasks

@main
struct HaloApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var userDefaultsObserver = UserDefaultsObserver()
    
    init() {
        UNUserNotificationCenter.current().delegate = appDelegate
        
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), nil, { (_, observer, name, _, _) in
            if name?.rawValue as! String == "io.nora.deviceActivityUpdate" {
                DispatchQueue.main.async {
                    // Update your UI or data here
                    let sharedDefaults = UserDefaults(suiteName: "group.io.nora.deviceActivity")
                    let activityValue = sharedDefaults?.string(forKey: "totalActivity")
                    print("Updated UserDefaults Value: \(activityValue ?? "No value found")")
                }
            }
        }, "io.nora.deviceActivityUpdate" as CFString, nil, .deliverImmediately)
    }
    
    var body: some Scene {
        let mainViewModel = MainViewModel()
        
        WindowGroup {
//            ConnectScreentime()
//                .onAppear {
//                    print("spotrusher")
//                }
            MainView(mainViewModel: mainViewModel)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    
                }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    let sharedDefaults = UserDefaults(suiteName: "group.io.nora.deviceActivity")
                    let activityValue = sharedDefaults?.string(forKey: "totalActivity")
                    print("Direct UserDefaults Value: \(activityValue ?? "No value found")")
                }

            
        }
//        .onChange(of: scenePhase) { newScenePhase in
//            switch newScenePhase {
//            case .background:
//                FamilyViewModel.shared.title = "shrues now"
//                print("App is in background")
//            case .active:
//                print("App is in foreground")
//            case .inactive:
//                print("App is inactive")
//            @unknown default:
//                print("Unknown scene phase")
//            }
//        }
    }
}

import Combine

class UserDefaultsObserver: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var totalActivity: String?

    init() {
        // this is getting triggered first 
        UserDefaults(suiteName: "group.io.nora.deviceActivity")?
            .publisher(for: \.totalActivity)
            .sink { [weak self] in
                self?.totalActivity = $0
                print($0 ?? "No value found", "mention that")
            }
            .store(in: &cancellables)
    }
}

extension UserDefaults {
    @objc dynamic var totalActivity: String? {
        get { string(forKey: "totalActivity") }
        set { set(newValue, forKey: "totalActivity") }
    }
}
