//
//  MainViewModel.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//

import Foundation
import Combine
import SwiftUI
import BackgroundTasks
import AVFoundation

class MainViewModel: ObservableObject {
    @Published var currentPage: Page = .home
    @Published var homeScreenIsReady = true
    
    @Published var selectedDifficulty: Difficulty = .normal
    @Published var selectedTime: TimeSelect = .five
    @Published var isTimerRunning: Bool = false
    @Published var timeRemaining: Int = 180
    @Published var progress: Double = 0.0 // Progress from 0.0 to 1.0
    @Published var selectedSchedule: Schedule = Schedule.templateSchedule
    @Published var user: User = User(name: "goat", avgScreentime: "2-4", coins: 100, guardians: [], dateJoined: Date(), schedules: [], limits: [])
    private var cancellables: Set<AnyCancellable> = []
    private var timerPublisher: AnyPublisher<Date, Never>?
    var formattedTime: String {
        return secondsToHoursMinutesSeconds(seconds: timeRemaining)
    }
    @Published var isBreakTime = false
    @Published var reward = 0
    @Published var activeSchedule: Schedule = Schedule.templateSchedule

    
    
    
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
//        UserDefaults.standard.removeObject(forKey: "user")
        user = UserDefaults.standard.retrieveUser() ?? User(name: "goat", avgScreentime: "2-4", coins: 100, guardians: [], dateJoined: Date(), schedules: [], limits: [])
    }
    
    
    deinit {
        stopFocusSession()
        NotificationCenter.default.removeObserver(self)
    }

    func getScheduleTimeRemaining() -> Int {
        var ret = 0
        for schedule in user.schedules {
            if schedule.isActive && schedule.isOn {
                activeSchedule = schedule
                let calendar = Calendar.current
                let now = Date()
                let ends = schedule.ends
                let currentHour = calendar.component(.hour, from: now)
                let currentMinute = calendar.component(.minute, from: now)

                let endHour = calendar.component(.hour, from: ends)
                let endMinute = calendar.component(.minute, from: ends)

                // Convert everything to minutes for easier comparison
                let currentTimeInMinutes = currentHour * 60 + currentMinute
                let endTimeInMinutes = endHour * 60 + endMinute

                if currentTimeInMinutes < endTimeInMinutes {
                    let minutesLeft = endTimeInMinutes - currentTimeInMinutes
                    let timeIntervalLeft: TimeInterval = TimeInterval(minutesLeft * 60) // Convert minutes to seconds
                    ret  = Int(timeIntervalLeft)
                    print("\(timeIntervalLeft) seconds left")
                } else {
                    print("The schedule has ended for today.")
                 
                }
            }
        }
        return ret

    }
    
    func startFocusSession() {
        if isTimerRunning { return } // If the timer is already running, return immediately
        
        timeRemaining = getScheduleTimeRemaining()
        
        UserDefaults.standard.set(Date(), forKey: "startTime")
        timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
        calculateReward()
        timerPublisher?
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.progress = Double(self.timeRemaining) / (UIScreen.main.bounds.width / 2)
                } else {
                    self.cancellables.forEach { $0.cancel() }
                    self.isTimerRunning = false
                    if isBreakTime { // reset to scheduled time or focustime left
                        timeRemaining = getScheduleTimeRemaining()
                        startFocusSession()
                        isBreakTime = false
                    } else {
                        calculateReward()
                    }
                }
            }
            .store(in: &cancellables)
        isTimerRunning = true
    }
    
    func calculateReward() {
        let calendar = Calendar.current
        let ends = activeSchedule.ends
        let starts = activeSchedule.starts
        let currentHour = calendar.component(.hour, from: starts)
        let currentMinute = calendar.component(.minute, from:  starts)

        let endHour = calendar.component(.hour, from: ends)
        let endMinute = calendar.component(.minute, from: ends)
//        if let rewardd = UserDefaults.standard.value(forKey: "currReward") as? Int {
//            reward = rewardd
//            reward += (endHour - currentHour) * 10
//        }
        // TODO: consequence for ending toggle early.
        reward = (endHour - currentHour) * 10
//        UserDefaults.standard.setValue(0, forKey: "lastHour")
//        UserDefaults.standard.setValue(0, forKey: "currReward")
        if reward > 120 { reward = 120  }
        user.coins += reward
        saveData()
        print("reward", reward)
    }
 
    func stopFocusSession() {
        cancellables.forEach { $0.cancel() }
        isTimerRunning = false
    }
    
    
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
    
    
    func saveData() {
        UserDefaults.standard.updateUser(user: self.user)
    }
    
    @objc func appMovedToForeground() {
        if let startTime = UserDefaults.standard.object(forKey: "startTime") as? Date {
            let elapsedTime = Int(Date().timeIntervalSince(startTime))
            timeRemaining -= elapsedTime
            // Update progress, etc.
        }
    }
    
    @objc func appMovedToBackground() {
//        let notificationContent = UNMutableNotificationContent()
//        notificationContent.title = "Timer Done!"
//        notificationContent.body = "Your timer has finished."
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeRemaining), repeats: false)
//        
//        let request = UNNotificationRequest(identifier: "timerDone", content: notificationContent, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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
    case rule
}



