//
//  Home.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var mainVM: MainViewModel
    @ObservedObject var homeVM: HomeViewModel
    @State private var animateBox = false
    
    var body: some View {
        GeometryReader { g in
            Clr.primaryBackground.ignoresSafeArea()
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
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
                        }
                        .padding(.horizontal, 8)
                        ZStack {
                            RoundedRectangle(cornerRadius: 32)
                                .frame(height:44)
                            HStack() {
                                Text("Screentime Limit: 3 Hrs")
                                    .foregroundColor(.white)
                                    .font(Font.prompt(.medium, size: 20))
                                Spacer()
                                Image(systemName: "pause.fill")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 20, height: 20)
                            }.padding(.horizontal, Constants.paddingLarge)
                        }
                        
                        BoxCard(size: BoxSize.big.rawValue) {
                            VStack(spacing: -16) {
                                Img.mainHalo
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .rotationEffect(.degrees(animateBox ? 8 : -4))
                                    .offset(y: animateBox ? -7 : 7)
                                    .animation(Animation.easeInOut(duration: 1)
                                        .repeatForever(autoreverses: true), value: animateBox)
                                    .onAppear() {
                                        self.animateBox.toggle()
                                    }
                                Text("Time Remaining: ")
                                    .foregroundColor(Clr.primary)
                                    .font(Font.prompt(.medium, size: 16))
                                Text("\(mainVM.formattedTime)")
                                    .font(Font.prompt(.bold, size: Constants.fontHuge))
                                    .foregroundColor(Clr.primary)
                                HStack {
                                    Rectangle()
                                        .fill(Clr.primarySecond)
                                        .frame(width: g.size.width * mainVM.progress, height: 16, alignment: .leading)
                                        .animation(.linear, value: mainVM.progress)
                                }.frame(width: g.size.width / 1.2, alignment: .leading)
                            }
                        }
                        
                        BoxCard(size: BoxSize.small.rawValue) {
                            VStack(alignment: .leading, spacing: -8){
                                Text("Total Screentime 📱")
                                    .font(Font.prompt(.medium, size: Constants.fontMedium))
                                    .foregroundColor(Clr.primary)
                                Text("2h 17m")
                                    .font(Font.prompt(.bold, size: Constants.fontTitle))
                                    .foregroundColor(Clr.primary)
                                //                                Text("+23% more than yesterday")
                                //                                .font(Font.prompt(.semiBoldItalic, size: Constants.fontSmall))
                                //                                .foregroundColor(Clr.primaryThird)
                            }.padding(.horizontal, Constants.paddingLarge)
                                .frame(width: g.size.width / 1.2, alignment: .leading)
                        }
                        HStack(spacing: 16) {
                            BoxCard(size: BoxSize.small.rawValue) {
                                VStack(alignment: .leading, spacing: 8) {
                                    VStack(spacing: -4) {
                                        Text("Difficulty")
                                            .foregroundColor(Clr.primaryThird)
                                            .font(Font.prompt(.medium, size: Constants.fontMedium))
                                        Text("Normal")
                                            .foregroundColor(Clr.primary)
                                            .font(Font.prompt(.bold, size: Constants.fontLarge))
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                    BlueArrow()
                                }.padding(.horizontal, Constants.paddingMedium)
                                
                            }
                            BoxCard(size: BoxSize.small.rawValue) {
                                VStack(alignment: .leading, spacing: -4) {
                                    Text("Pickups 🤳")
                                        .font(Font.prompt(.medium, size: Constants.fontMedium))
                                    Text("32")
                                        .font(Font.prompt(.bold, size: Constants.fontTitle))
                                }.foregroundColor(Clr.primary)
                                    .padding(.horizontal, Constants.paddingMedium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        BoxCard(size: BoxSize.small.rawValue) {
                            VStack(alignment: .leading, spacing: 0){
                                Text("Upcoming Schedule")
                                    .font(Font.prompt(.medium, size: Constants.fontMedium))
                                    .foregroundColor(Clr.primary)
                                Text("Morning")
                                    .font(Font.prompt(.bold, size: Constants.fontLarge))
                                    .foregroundColor(Clr.primary)
                                //                                Text("+23% more than yesterday")
                                //                                .font(Font.prompt(.semiBoldItalic, size: Constants.fontSmall))
                                //                                .foregroundColor(Clr.primaryThird)
                                HStack {
                                    Spacer()
                                    BlueArrow()
                                }

                            }.padding(.horizontal, Constants.paddingLarge)
                                .frame(width: g.size.width / 1.2, alignment: .leading)
                        }
                    }.padding(.horizontal, Constants.paddingXL)
                }
            }
        }.onAppear {}
        
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .padding(.horizontal, Constants.paddingStandard)
//            .padding(.vertical, Constants.paddingSmall)
//
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(mainVM: MainViewModel(), homeVM: HomeViewModel(mainViewModel: MainViewModel()))
    }
}
