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

// cant get app icons on IOS 17, only iphone apps

struct StatsActivityView: View {
    var activityReport: ActivityReport
    
    @State var totalDurationInSeconds: Int

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(activityReport: ActivityReport) {
        self.activityReport = activityReport
        self._totalDurationInSeconds = State(initialValue: Int(activityReport.totalDuration))
    }
    
    /// row with two rectangles with screentime and pickups inside of it
    var body: some View {
        GeometryReader { geometry in
            HStack() {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color(hex: 0xFF372A55))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: 0x4D6547B0), lineWidth: 2)
                        )
                        .frame(width: geometry.size.width * 0.47, height: geometry.size.height * 0.85)
    //                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Screentime")
                                    .font(.custom("IBMPlexMono-Light", size: 12))
                                    .foregroundColor(Color(hex: 0xFFFFFFFF))
                                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 50))

                                Text(activityReport.totalDuration.stringFromTimeInterval())
                                    .font(.custom("IBMPlexMono-Bold", size: 20))
                                    .foregroundColor(Color(hex: 0xFFFFFFFF))
                                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 50))
                            }
                        )
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color(hex: 0xFF372A55))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: 0x4D6547B0), lineWidth: 2)
                        )
                        .frame(width: geometry.size.width * 0.47, height: geometry.size.height * 0.85)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Screen Unlocks")
                                    .font(.custom("IBMPlexMono-Light", size: 12))
                                    .foregroundColor(Color(hex: 0xFFFFFFFF))
                                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 30))
                                
                                Text(String(activityReport.numberOfPickUps))
                                    .font(.custom("IBMPlexMono-Bold", size: 24))
                                    .foregroundColor(Color(hex: 0xFFFFFFFF))
                                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 30))

                            }
                        )
            }.padding(.top, 5)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // .background(Color(hex: 0xFFFAFAFA)
        .background(Color.red)
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(.all)
    }

}

