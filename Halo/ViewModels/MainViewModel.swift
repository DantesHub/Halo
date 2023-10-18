//
//  MainViewModel.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var currentPage: Page = .home
    @Published var homeScreenIsReady = true
    
    @Published var selectedDifficulty: Difficulty = .normal
    
    @Published var timeRemaining: Int = 180 // 3 hours in minutes, adjust as needed
    @Published var progress: Double = 0.0 // Progress from 0.0 to 1.0
    
    private var cancellables: Set<AnyCancellable> = []
    private var timerPublisher: AnyPublisher<Date, Never>?
    var formattedTime: String {
        return secondsToHoursMinutesSeconds(seconds: timeRemaining)
    }
    
    // Schedules
    @Published var days: [Day] = [
         Day(name: "S"),
         Day(name: "M"),
         Day(name: "T"),
         Day(name: "W"),
         Day(name: "T"),
         Day(name: "F"),
         Day(name: "S")
     ]
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    deinit {
        stopFocusSession()
        NotificationCenter.default.removeObserver(self)
    }

    
    
    func startFocusSession() {
        UserDefaults.standard.set(Date(), forKey: "startTime")
        timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
        
        timerPublisher?
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.progress = Double(self.timeRemaining) / (UIScreen.main.bounds.width / 2)
                } else {
                    self.cancellables.forEach { $0.cancel() }
                }
            }
            .store(in: &cancellables)
    }
    
    func stopFocusSession() {
        cancellables.forEach { $0.cancel() }        }
    
    
    func secondsToHoursMinutesSeconds (seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    @objc func appMovedToForeground() {
        if let startTime = UserDefaults.standard.object(forKey: "startTime") as? Date {
            let elapsedTime = Int(Date().timeIntervalSince(startTime))
            timeRemaining -= elapsedTime
            // Update progress, etc.
        }
    }
    
    @objc func appMovedToBackground() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Timer Done!"
        notificationContent.body = "Your timer has finished."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeRemaining), repeats: false)
        
        let request = UNNotificationRequest(identifier: "timerDone", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @objc func appWillTerminate() {
        // Handle the app termination
        // TODO: second sprint
    }
}

enum Page {
    case home
    case onboarding
    case leaderboard
    case store
    case profile
    case stats
}



struct Day: Identifiable {
 let id = UUID()  
 let name: String
 var isSelected: Bool = true
}
