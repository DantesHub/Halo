//
//  Home.swift
//  Halo
//
//  Created by Dante Kim on 8/30/23.
//

import SwiftUI
import FamilyControls
import DeviceActivity

extension DeviceActivityReport.Context {
    static let totalActivity = Self("pieChart")
}

struct HomeScreen: View {
    @ObservedObject var mainVM: MainViewModel
    @ObservedObject var homeVM: HomeViewModel
    @StateObject var familyModel = FamilyViewModel.shared
    @State private var animateBox = false
    @State var isPresented = false
    @State private var title = ""
    @State private var activeSchedule: Schedule = Schedule.templateSchedule
    @Binding var addAppSchedule: Bool
    @Binding var showUnlock: Bool
    @State private var context: DeviceActivityReport.Context = .totalActivity
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
        GeometryReader { g in
            Clr.primaryBackground.ignoresSafeArea()
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 32)
                                .frame(height:44)
                            HStack() {
                                Text(title == "" ? "Start Focus Session" : title)
                                    .foregroundColor(.white)
                                    .font(Font.prompt(.medium, size: 20))
                                Spacer()
                                Image(systemName: title == ""  ? "play.fill" : "pause.fill")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 20, height: 20)
                                    .onTapGesture {
                                        Task {
                                            do {
                                                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                                                familyModel.title = "focus"
                                                familyModel.restoreBlockedApps()
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
                                    }
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
                                Text(mainVM.isBreakTime ? "Break Time:" : "Time Remaining: ")
                                    .foregroundColor(Clr.primary)
                                    .font(Font.prompt(.medium, size: 16))
                                Text("\(mainVM.formattedTime)")
                                    .font(Font.prompt(.bold, size: Constants.fontBig / (UIDevice.isSmall ? 1.5 : 1)))
                                    .foregroundColor(Clr.primary)
                                
                                HStack {
                                    Rectangle()
                                        .fill(Clr.primarySecond)
                                        .frame(width: g.size.width * mainVM.progress, height: 16, alignment: .leading)
                                        .animation(.linear, value: mainVM.progress)
                                }.frame(width: g.size.width / 1.2, alignment: .leading)
                            }
                        }
                        ScheduleCard(schedule: activeSchedule, showUnlock: $showUnlock, mainVM: mainVM)  {
                            withAnimation {
                                mainVM.selectedSchedule = activeSchedule
                                addAppSchedule.toggle()
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
                        BoxCard(size: BoxSize.small.rawValue) {
                            DeviceActivityReport(context, filter: filter)
                        }.frame(width: g.size.width / 1.2, alignment: .leading)
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
        }.onAppear {
            updateData()
            let sharedDefaults = UserDefaults(suiteName: "group.io.nora.deviceActivity")
            let data = sharedDefaults?.object(forKey: "totalActivity")
            print(data, "westside")
        }
        .familyActivityPicker(isPresented: $isPresented, selection: $familyModel.selectionToDiscourage)
        .onChange(of: mainVM.user.schedules) { newValue in
            if !newValue.isEmpty { updateData() }
        }
        
    }
    func updateData() {
        for schedule in mainVM.user.schedules {
            if schedule.isActive && schedule.isOn {
                title = schedule.title
                mainVM.startFocusSession()
                activeSchedule = schedule
                break
            } else if schedule.isActive {
                activeSchedule = schedule
            }
        }
    }
}
    
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(mainVM: MainViewModel(), homeVM: HomeViewModel(mainViewModel: MainViewModel()), addAppSchedule: .constant(false), showUnlock: .constant(false))
    }
}
