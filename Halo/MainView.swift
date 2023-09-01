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
    
    init(mainViewModel: MainViewModel) {
        _mainVM = StateObject(wrappedValue: mainViewModel)
        _authVM = StateObject(wrappedValue: AuthViewModel(mainViewModel: mainViewModel))
        _homeVM = StateObject(wrappedValue: HomeViewModel(mainViewModel: mainViewModel))
    }
    
    var body: some View {
        if mainVM.homeScreenIsReady {
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
                BoxCard(size: BoxSize.option.rawValue) {
                    HStack {
                        VStack(spacing: -4) {
                            Image(systemName: "person.2.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Clr.primary)
                                .frame(width: 28, height: 28)
                            Text("Friends")
                                .font(Font.prompt(.medium, size: 12))
                        }
                        Spacer()
                        VStack(spacing: -4) {
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Clr.primary)
                                .frame(width: 28, height: 28)
                            Text("Home")
                                .font(Font.prompt(.medium, size: 12))
                        }
                        ZStack {
                            Circle()
                                .fill(Color.yellow)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 4)
                                )
                                .frame(width: 56, height: 56)
                                .shadow(radius: 2)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(Font.system(.title).weight(.black))
                                .foregroundColor(.white)
                        }.offset(x: 0, y: -20)
                            .padding(.horizontal, 4)
                        VStack(spacing: -4) {
                            Img.shoppingIcon
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Clr.primary)
                                .frame(width: 28, height: 28)
                            Text("Store")
                                .font(Font.prompt(.medium, size: 12))
                        }
                        Spacer()
                        VStack(spacing: -4) {
                            Image(systemName: "chart.bar.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Clr.primary)
                                .frame(width: 28, height: 28)
                            Text("Store")
                                .font(Font.prompt(.medium, size: 12))
                        }
                       
                    }.padding(.horizontal, 24)
                }.padding(.horizontal, Constants.paddingXL)
            }
           .navigationBarTitle("Gangs")
            .navigationBarHidden(true)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(mainViewModel: MainViewModel())
    }
}
