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
    @State var tappedPlus: Bool = false
    
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
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .foregroundColor(Clr.primary)
                            .frame(width: 26, height: 26)
                    }.padding(.horizontal, Constants.paddingXLL)
                    .padding(.bottom, 16)
                    ZStack {
                        Color.white.ignoresSafeArea()
                        switch mainVM.currentPage {
                        case .home:
                            HomeScreen()
                                .environmentObject(homeVM)
                        default: HomeScreen()
                        }
                    }
                    TabBar(mainVM: mainVM, tappedPlus: $tappedPlus)

                }
            
                Color.black.opacity(tappedPlus ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            tappedPlus.toggle()
                        }
                    }
                
                FocusModal(tappedPlus: $tappedPlus)
                    .offset(y: tappedPlus ?  (UIScreen.main.bounds.height / 2 - 150) : UIScreen.main.bounds.height)
            }
        
           .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(mainViewModel: MainViewModel())
    }
}
