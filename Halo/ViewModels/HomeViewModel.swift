//
//  HomeViewModel.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//
import Foundation

class HomeViewModel: ObservableObject {
    private(set) var mainVM: MainViewModel
    // Timer properties
    @Published var timeRemaining: Int = 180 // 3 hours in minutes, adjust as needed
    @Published var progress: Double = 0.0 // Progress from 0.0 to 1.0
    var timer: Timer?
    
    init(mainViewModel: MainViewModel) {
        self.mainVM = mainViewModel
        // Populate isLoading and medias with all possible section keys
    }
    
    func startTimer() {
            timer?.invalidate() // Invalidate any existing timer
            timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
                if self.timeRemaining > 0 {
                    self.mainVM.timeRemaining -= 1
                    self.progress = Double(180 - self.timeRemaining) / 180.0
                } else {
                    self.timer?.invalidate()
                    // Notify user or perform any other actions when timer is done
                }
            }
        }

        func stopTimer() {
            timer?.invalidate()
        }

        deinit {
            stopTimer()
        }
}
