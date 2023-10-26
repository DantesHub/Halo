//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI
import Lottie

struct ScheduleSuccess: View {
    @ObservedObject var mainVM: MainViewModel
    @Binding var showModal: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                }.frame(height: 64)
                Text("🎁")
                    .font(Font.system(size: 72)) // Adjust the size
                    .frame(height: 80)
                    .padding(.bottom)
                VStack(spacing: 0) {
                    Text(mainVM.activeSchedule.title)
                        .font(Font.prompt(.bold, size: 20))
                        .foregroundColor(Clr.primarySecond)
                    Text("\(mainVM.activeSchedule.starts.toString()) - \(mainVM.activeSchedule.ends.toString())")
                        .font(Font.prompt(.medium, size: 24))
                        .foregroundColor(Clr.primary)
                    Text("115 Minutes")
                        .font(Font.prompt(.bold, size: 36))
                        .foregroundColor(Clr.primarySecond)
                    
                    HStack(spacing: 12) {
                        Text("Blocked:")
                            .font(Font.prompt(.italic, size: 20))
                            .foregroundColor(Clr.primary)
                        Spacer()
                        Image(systemName: "lock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color.gray)
                        if mainVM.activeSchedule.categoriesCount > 0 {
                            HStack(spacing: 4) {
                                if mainVM.activeSchedule.categoriesCount == 13 {
                                    Text("All Apps 😤")
                                        .font(Font.prompt(.regular, size: 16))
                                } else {
                                    Image(systemName: "square.grid.2x2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                    Text("\(mainVM.activeSchedule.categoriesCount) categories")
                                        .font(Font.prompt(.regular, size: 16))
                                }
                            }
                        }
                        if mainVM.activeSchedule.appsCount > 0 {
                            HStack(spacing: 4) {
                                Image(systemName: "apps.iphone")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                Text("\(mainVM.activeSchedule.appsCount) apps")
                                    .font(Font.prompt(.regular, size: 16))
                            }
                        }
                    }.foregroundStyle(Clr.primary)
                    .padding(.horizontal, 8)
                }
                
                HStack {}.frame(height: 60) .padding(.bottom)
                
        
            }.frame(width: UIScreen.main.bounds.width / 1.5, height: 400)
                .padding(.horizontal, 16)
                .foregroundColor(Clr.primary)
                .background(Clr.primaryBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Clr.primary, lineWidth: 7)
                )
                .cornerRadius(24)
            LottieView(loopMode: .playOnce, animation: "confetti")
                .frame(width: 400, height: 400)
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        withAnimation {
                            print("tapping here")
                            showModal.toggle()
                        }
                    }.zIndex(1000)
                Spacer()
                Text("You did it!")
                    .font(Font.prompt(.medium, size: 20))
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .opacity(0)
            }.frame(width: UIScreen.main.bounds.width / 1.5)
            .offset(y: -160)
            PrimaryButton(img: Img.haloCoin, title: "Claim \(mainVM.reward) coins", action: {
                print("tapping here")
            })
            .frame(width: UIScreen.main.bounds.width / 1.5)
            .offset(y: 160)

        }
    }
}

struct ScheduleSuccess_Previews: PreviewProvider {
    static var previews: some View {
        MiddleModal(showModal: .constant(false))
    }
}
