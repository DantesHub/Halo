//
//  HaloApp.swift
//  Halo
//
//  Created by Dante Kim on 8/26/23.
//

import SwiftUI

@main
struct HaloApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        UNUserNotificationCenter.current().delegate = appDelegate
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
                }

        }
    }
}
