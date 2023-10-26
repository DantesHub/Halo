//
//  TotalActivityView.swift
//  doxoscreentime
//
//  Created by Teju Sharma on 7/22/23.
//

import SwiftUI
import DeviceActivity
import ScreenTime
import Foundation
import FamilyControls
import ManagedSettings
import WidgetKit


struct TotalActivityView: View {
    var activityReport: ActivityReport
    
    @State var totalDurationInSeconds: Int

//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(activityReport: ActivityReport) {
        self.activityReport = activityReport
        self._totalDurationInSeconds = State(initialValue: Int(activityReport.totalDuration))      
    }
    
    /// row with two rectangles with screentime and pickups inside of it
    var body: some View {
        GeometryReader { g in
            VStack(alignment: .leading) {
                BoxCard(size: BoxSize.small.rawValue) {
                    VStack(alignment: .leading, spacing: -8){
                        Text("Total Screentime2 📱")
                            .font(Font.prompt(.medium, size: Constants.fontMedium))
                            .foregroundColor(Clr.primary)
                        Text("\(activityReport.totalDuration.stringFromTimeInterval())")
                            .font(Font.custom("Prompt-Bold", size: 32))
                            .foregroundColor(Clr.primary)
                        //  Text("+23% more than yesterday")
                        // .font(Font.prompt(.semiBoldItalic, size: Constants.fontSmall))
                        // .foregroundColor(Clr.primaryThird)
                    }.padding(.horizontal, Constants.paddingLarge)
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
            }
//            HStack() {
//                    RoundedRectangle(cornerRadius: 12)
//                        .foregroundColor(Color(hex: 0xFF372A55))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color(hex: 0x4D6547B0), lineWidth: 2)
//                        )
//                        .frame(width: geometry.size.width * 0.47, height: geometry.size.height * 0.85)
//    //                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                        .overlay(
//                            VStack(alignment: .leading, spacing: 2) {
//                                Text("Screentime")
//                                    .font(.custom("IBMPlexMono-Light", size: 12))
//                                    .foregroundColor(Color(hex: 0xFFFFFFFF))
//                                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 50))
//
//                                Text(activityReport.totalDuration.stringFromTimeInterval())
//                                    .font(.custom("IBMPlexMono-Bold", size: 20))
//                                    .foregroundColor(Color(hex: 0xFFFFFFFF))
//                                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 50))
//                            }
//                        )
//                    
//                    Spacer()
//                    
//                    RoundedRectangle(cornerRadius: 12)
//                        .foregroundColor(Color(hex: 0xFF372A55))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color(hex: 0x4D6547B0), lineWidth: 2)
//                        )
//                        .frame(width: geometry.size.width * 0.47, height: geometry.size.height * 0.85)
//                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                        .overlay(
//                            VStack(alignment: .leading, spacing: 2) {
//                                Text("Screen Unlocks")
//                                    .font(.custom("IBMPlexMono-Light", size: 12))
//                                    .foregroundColor(Color(hex: 0xFFFFFFFF))
//                                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 30))
//                                
//                                Text(String(activityReport.numberOfPickUps))
//                                    .font(.custom("IBMPlexMono-Bold", size: 24))
//                                    .foregroundColor(Color(hex: 0xFFFFFFFF))
//                                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 30))
//
//                            }
//                        )
//            }.padding(.top, 5)

        }
        // .background(Color(hex: 0xFFFAFAFA)
//        .background(Color(hex: 0xFF1B1631))       
        .foregroundColor(Color(hex: 0xFF1B1631))
        .padding(8)
    }

}

extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
