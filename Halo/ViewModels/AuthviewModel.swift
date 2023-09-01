//
//  AuthviewModel.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//

import Foundation
class AuthViewModel: ObservableObject {
    var mainViewModel: MainViewModel
    @Published var isLoading = true
    @Published var finishedAuthentication = false
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
}
