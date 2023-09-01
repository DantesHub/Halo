//
//  HaloApp.swift
//  Halo
//
//  Created by Dante Kim on 8/26/23.
//

import SwiftUI

@main
struct HaloApp: App {
    var body: some Scene {
        let mainViewModel = MainViewModel()
        
        WindowGroup {
            MainView(mainViewModel: mainViewModel)
        }
    }
}
