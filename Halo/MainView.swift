//
//  ContentView.swift
//  Halo
//
//  Created by Dante Kim on 8/26/23.
//

import SwiftUI


struct MainView: View {
    @StateObject var mainVM: MainViewModel
    @StateObject var authVM: AuthViewModel
    @StateObject var homeVM: HomeViewModel
    @State private var tappedPlus: Bool = false
    @State private var showModal: Bool = true
    @State private var tappedDifficulty: Bool = false
    
    init(mainViewModel: MainViewModel) {
        _mainVM = StateObject(wrappedValue: mainViewModel)
        _authVM = StateObject(wrappedValue: AuthViewModel(mainViewModel: mainViewModel))
        _homeVM = StateObject(wrappedValue: HomeViewModel(mainViewModel: mainViewModel))
    
    }
    
    var body: some View {
        if mainVM.homeScreenIsReady {
            ZStack {
                VStack {
                  
                    ZStack {
                        Color.white.ignoresSafeArea()
                        switch mainVM.currentPage {
                        case .home:
                            HomeScreen(mainVM: mainVM, homeVM: homeVM)
                                .environmentObject(homeVM)
                        case .store:
                            ShopScreen()
                        default: HomeScreen(mainVM: mainVM, homeVM: homeVM)
                        }
                    }
                    TabBar(mainVM: mainVM, tappedPlus: $tappedPlus)

                }
            
                Color.black.opacity(tappedPlus || showModal ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            tappedPlus = false
                            showModal = false
                            tappedDifficulty = false
                        }
                    }
                
                FocusModal(mainVM: mainVM, tappedPlus: $tappedPlus, tappedDifficulty: $tappedDifficulty)
                    .offset(y: tappedPlus ?  (UIScreen.main.bounds.height / 2 - 164) : UIScreen.main.bounds.height)
                MiddleModal(showModal: $showModal)
                    .offset(y: showModal ?  0 : UIScreen.main.bounds.height)
                DifficultyModal(mainVM: mainVM, showDifficulty: $tappedDifficulty)
                    .offset(y: tappedDifficulty ?  (UIScreen.main.bounds.height / 2 - 172) : UIScreen.main.bounds.height)

            }
        
           .navigationBarTitle("")
            .navigationBarHidden(true)
        } else {
            OnboardingScreen(mainVM: mainVM)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(mainViewModel: MainViewModel())
    }
}
