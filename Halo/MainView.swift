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
    @StateObject var familyModel = FamilyViewModel.shared
    @State private var tappedPlus: Bool = false
    @State private var showModal: Bool = false
    @State private var tappedDifficulty: Bool = false
    @State private var showShop: Bool = false
    @State private var showUnlock: Bool = false
    @State private var addAppLimit: Bool = false
    @State private var addAppSchedule: Bool = false

    
    init(mainViewModel: MainViewModel) {
        _mainVM = StateObject(wrappedValue: mainViewModel)
        _authVM = StateObject(wrappedValue: AuthViewModel(mainViewModel: mainViewModel))
        _homeVM = StateObject(wrappedValue: HomeViewModel(mainViewModel: mainViewModel))
    
    }
    
    var body: some View {
        if mainVM.homeScreenIsReady {
            ZStack {
                VStack {
                    HStack {
                        Text("Home")
                            .foregroundColor(Clr.primary)
                            .font(Font.prompt(.medium, size: 24))
                        Spacer()
                        Img.shoppingIcon
                            .resizable()
                            .frame(width: 32, height: 32)
                            .onTapGesture {
                                UIImpactFeedbackGenerator(style: .light)
                                    .impactOccurred()
                                withAnimation {
                                    showShop.toggle()
                                }
                            }
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .foregroundColor(Clr.primary)
                            .frame(width: 26, height: 26)
                    }
                    .padding(.horizontal, Constants.paddingXL)
                    ZStack {
                        Color.white.ignoresSafeArea()
                        switch mainVM.currentPage {
                            case .home:
                                HomeScreen(mainVM: mainVM, homeVM: homeVM)
                                    .environmentObject(homeVM)
                            case .store:
                                EmptyView()
                            case .rule:
                                RulesScreen(mainVM: mainVM, addAppLimit: $addAppLimit, addAppSchedule: $addAppSchedule)
                            default: HomeScreen(mainVM: mainVM, homeVM: homeVM)
                        }
                    }
                    TabBar(mainVM: mainVM, tappedPlus: $tappedPlus)

                }
            
                Color.black.opacity(tappedPlus || showModal || addAppSchedule || addAppLimit ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            tappedPlus = false
                            showModal = false
                            tappedDifficulty = false
                            addAppSchedule = false
                            addAppLimit = false
                        }
                    }
                
                FocusModal(mainVM: mainVM, tappedPlus: $tappedPlus, tappedDifficulty: $tappedDifficulty)
                    .offset(y: tappedPlus ?  (UIScreen.main.bounds.height / 2 - 164) : UIScreen.main.bounds.height)
                MiddleModal(showModal: $showModal)
                    .offset(y: showModal ?  0 : UIScreen.main.bounds.height)
                DifficultyModal(mainVM: mainVM, showDifficulty: $tappedDifficulty)
                    .offset(y: tappedDifficulty ?  (UIScreen.main.bounds.height / 2 - 172) : UIScreen.main.bounds.height)
                UnlockModal(mainVM: mainVM, showUnlock: $showUnlock)
                    .offset(y: showUnlock ?  (UIScreen.main.bounds.height / 2 - 172) : UIScreen.main.bounds.height)
                AppLimitsModal(mainVM: mainVM, showAppLimits: $addAppLimit)
                    .offset(y: addAppLimit ?  (UIScreen.main.bounds.height / 2 - 224) : UIScreen.main.bounds.height)
                AppScheduleModal(mainVM: mainVM, showAppSession: $addAppSchedule)
                    .offset(y: addAppSchedule ?  (UIScreen.main.bounds.height / (mainVM.selectedSchedule.isAllDay ? 5.5 : 8)) : UIScreen.main.bounds.height)
                
            }
           .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showShop) {
                ShopScreen(isPresented: $showShop)
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("breakTime")), perform: { _ in
                withAnimation {
                    showUnlock.toggle()
                }
            })
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
