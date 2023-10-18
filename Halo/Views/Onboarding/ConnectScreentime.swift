//
//  GraphScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/6/23.
//

import SwiftUI
import FamilyControls
import _DeviceActivity_SwiftUI

extension DeviceActivityReport.Context {
  static let totalActivity = Self("Total Activity")
}

struct ConnectScreentime: View {
    @State var isPresented = false
    @StateObject var familyModel = FamilyModel.shared
    
    let context: DeviceActivityReport.Context = .totalActivity
      let filter = DeviceActivityFilter(
      segment:.daily(
        during: DateInterval(
          start: Date().addingTimeInterval(-1),
          end: Date()
        )
      ))
    
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
            Img.halo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160)
                .offset(y: 20)
            BoxCard(size: 4) {
                
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
      
        }
        .padding(.horizontal, 48)
    }
}



struct ConnectScreentime_Previews: PreviewProvider {
    static var previews: some View {
        ConnectScreentime()
    }
}
