//
//  MainViewModel.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var currentPage: Page = .home
    @Published private(set) var homeScreenIsReady = true
    
    
    enum Page {
      case home
      case onboarding
      case leaderboard
      case store
      case profile
      case stats
    }
}
