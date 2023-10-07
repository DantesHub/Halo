//
//  TabBar.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct TabBar: View {
    @StateObject var mainVM: MainViewModel
    @Binding var tappedPlus: Bool
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .fill(Clr.primaryBackground)
                .primaryShadow()
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .stroke(.black, lineWidth: 4)
            VStack {
                
                HStack {
                    VStack(spacing: -4) {
                        Image(systemName: "person.2.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(mainVM.currentPage == .leaderboard ? Clr.primarySecond : Clr.primary)
                            .frame(width: 28, height: 28)
                        Text("Friends")
                            .font(Font.prompt(.medium, size: 12))
                    }.onTapGesture {
                        mainVM.homeScreenIsReady = false
                        mainVM.currentPage = .leaderboard
                    }
                    Spacer()
                    VStack(spacing: -4) {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(mainVM.currentPage == .home ? Clr.primarySecond : Clr.primary)
                            .frame(width: 28, height: 28)
                        Text("Home")
                            .font(Font.prompt(.medium, size: 12))
                    }.onTapGesture {
                        mainVM.currentPage = .home
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
                        .onTapGesture {
                            withAnimation {
                                tappedPlus.toggle()
                            }
                        }
                    VStack(spacing: -4) {
                        Img.shoppingIcon
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(mainVM.currentPage == .store ? Clr.primarySecond : Clr.primary)
                            .frame(width: 28, height: 28)
                        Text("Store")
                            .font(Font.prompt(.medium, size: 12))
                    }.onTapGesture {
                        mainVM.currentPage = .store
                    }
                    Spacer()
                    VStack(spacing: -4) {
                        Image(systemName: "chart.bar.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(mainVM.currentPage == .stats ? Clr.primarySecond : Clr.primary)
                            .frame(width: 28, height: 28)
                        Text("Stats")
                            .font(Font.prompt(.medium, size: 12))
                    }.onTapGesture {
                        mainVM.currentPage = .stats
                    }
                }.padding(.horizontal, 24)
            }
        }.padding(.horizontal, Constants.paddingXL)
        .frame(height: UIScreen.main.bounds.height / 14)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(mainVM: MainViewModel(), tappedPlus: .constant(false))
    }
}
