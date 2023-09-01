//
//  HomeViewModel.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//
import Foundation

class HomeViewModel: ObservableObject {
    private(set) var mainVM: MainViewModel
    
    init(mainViewModel: MainViewModel) {
        self.mainVM = mainViewModel
        // Populate isLoading and medias with all possible section keys
    }
}
