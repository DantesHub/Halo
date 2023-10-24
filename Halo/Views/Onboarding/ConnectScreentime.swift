//
//  GraphScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/6/23.
//

import SwiftUI
import FamilyControls
import Report
import DeviceActivity

extension DeviceActivityReport.Context {
  static let totalActivity = Self("Total Activity")
  static let stats = Self("Stats")
}


struct ConnectScreentime: View {
    @State var isPresented = false
    @StateObject var familyModel = FamilyViewModel.shared
 
    @State private var context: DeviceActivityReport.Context = .stats
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone])
    )
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: -16){
                Text("Connect your")
                HStack(spacing:0) {
                    Text("screentime")
                }
              
            }.font(Font.prompt(.bold, size: 36))
                .multilineTextAlignment(.center)
                .foregroundColor(Clr.primary)
                .lineSpacing(-8)
                .padding(.top, Constants.paddingXLL)
            Spacer()
            Img.halo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160)
                .offset(y: 20)
            BoxCard(size: 4) {
                DeviceActivityReport(context, filter: filter)
            }
            Img.blueArrow
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160)
                .position(x: 0, y: 20)
            Spacer()
            PrimaryButton(title: "Continue") {
                Task {
                    do {
                        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                        isPresented = true
                    } catch {
                        print("failed to enroll \(error)")
                    }

                    _ = AuthorizationCenter.shared.$authorizationStatus
                        .sink() {_ in
                        switch AuthorizationCenter.shared.authorizationStatus {
                        case .notDetermined:
                            print("not determined")
                        case .denied:
                            print("denied")
                        case .approved:
                            print("approved")
                        @unknown default:
                            break
                        }
                    }
                }

            }.padding(.bottom, Constants.paddingXLL)
            .familyActivityPicker(isPresented: $isPresented, selection: $familyModel.selectionToDiscourage)
        }.onAppear {
            // Create a new instance of the DeviceActivityReport class.
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                
            }
        }
        .padding(.horizontal, 48)
    }
}



struct ConnectScreentime_Previews: PreviewProvider {
    static var previews: some View {
        ConnectScreentime()
    }
}
