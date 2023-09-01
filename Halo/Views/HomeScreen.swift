//
//  Home.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        GeometryReader { g in
            Clr.primaryBackground.ignoresSafeArea()
            ZStack {
                VStack(spacing: 24) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 32)
                            .frame(height:44)
                        HStack() {
                            Text("Stop Focus Session...")
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
                        
                    }
                    
                    BoxCard(size: BoxSize.small.rawValue) {
                        VStack(alignment: .leading, spacing: -8){
                                Text("Screentime 📱")
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
                                } .frame(maxWidth: .infinity, alignment: .leading)
                                Image(systemName: "chevron.right.circle.fill")
                                    .resizable()
                                    .foregroundColor(Clr.primaryThird)
                                    .frame(width: 28, height: 28)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
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
                }.padding(.horizontal, Constants.paddingXL)
            }
        }
        
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .padding(.horizontal, Constants.paddingStandard)
//            .padding(.vertical, Constants.paddingSmall)
//
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
