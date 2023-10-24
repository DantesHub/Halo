//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct AppScheduleModal: View {
    @ObservedObject var mainVM: MainViewModel
    @State private var toggleBreaks: Bool = false
    @State private var toggleAllDay: Bool = false
    @State private var showTextField: Bool = false
    @State private var sessionTitle: String = "💎 My Schedule"
    @Binding var showAppSession: Bool
    @StateObject var familyViewModel = FamilyViewModel.shared
    @State private var presentFamilyPicker = false
    @State private var starts: Date = Calendar.current.date(from: DateComponents(hour: 0, minute: 0))!
    @State private var ends: Date = Calendar.current.date(from: DateComponents(hour: 23, minute: 59))!
    @State private var days: [Day] = [Day(name: "S"),Day(name: "M"), Day(name: "T"), Day(name: "W"),Day(name: "T"),Day(name: "F"),Day(name: "S")]
    
    var isAtLeastOneDaySelected: Bool {
        return days.contains { $0.isSelected }
    }

    var body: some View {
        
        VStack{
            Spacer()
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        withAnimation {
                            showAppSession.toggle()
                        }
                    }
                Spacer()
                if !showTextField {
                    HStack {
                        Text("\(sessionTitle)")
                            .font(Font.prompt(.medium, size: 24))
                            .frame(height: 32, alignment: .center)
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16)
                            .onTapGesture {
                                UIImpactFeedbackGenerator(style: .light)
                                    .impactOccurred()
                                  showTextField = true
                            }
                    }
              
                } else {
                    TextField("Limit Name", text: $sessionTitle)
                        .font(Font.prompt(.medium, size: 24)) // H1 title style
                        .background(Color.clear)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                }

                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .opacity(0)
            }.padding(.vertical)
            VStack(spacing: 24) {
                VStack {
                    HStack {
                        Text("Block")
                            .font(Font.prompt(.regular, size: 16))
                        Spacer()
                    }
                    VStack(alignment: .center, spacing: 16) {
                        HStack {
                            Text("Apps Blocked")
                            Spacer()
                            if familyViewModel.appsCount == 0 && familyViewModel.categoriesCount == 0   {
                                Text("Select Apps")
                                    .foregroundStyle(Clr.primaryThird)
                            } else {
                                Image(systemName: "lock.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                                if familyViewModel.categoriesCount > 0 {
                                    HStack(spacing: 4) {
                                        Image(systemName: "square.grid.2x2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 16)
                                        Text("\(familyViewModel.categoriesCount)")
                                            .font(Font.prompt(.regular, size: 16))
                                    }
                                }
                                if familyViewModel.appsCount > 0 {
                                    HStack(spacing: 4) {
                                        Image(systemName: "apps.iphone")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 10)
                                        Text("\(familyViewModel.appsCount)")
                                            .font(Font.prompt(.regular, size: 16))
                                    }
                                }
                            }
                            BlueArrow()
                        }.padding(.horizontal)
                            .onTapGesture {
                                withAnimation {
                                    familyViewModel.title = mainVM.selectedSchedule.id.uuidString
                                    familyViewModel.restoreBlockedApps()
                                    presentFamilyPicker = true
                                }
                            }
                        Rectangle()
                            .frame(height: 2.5)
                            .foregroundColor(Clr.primary)
                        HStack(alignment: .center, spacing: 0) {
                            VStack {
                                HStack {
                                    Text("Breaks")
                                    Spacer()
                                }
                                HStack {
                                    Text("Use coins to unblock apps")
                                        .font(Font.prompt(.italic, fixedSize: 12))
                                        .foregroundStyle(.gray)
                                    Spacer()
                                }
                            }.frame(width: UIScreen.main.bounds.width / 1.7)
                            Toggle("", isOn: $toggleBreaks)
                                .tint(Clr.primarySecond)
                            // TODO: - add specific days of the week.
                        } .padding(.horizontal)
                    }.frame(height: 136)
                        .background(Clr.primaryBackground)
                        .cornerRadius(24)
                        .font(Font.prompt(.regular, size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Clr.primary, lineWidth: 2.5)
                        )
                }
                VStack(spacing: 16) {
                    HStack {
                        Text("When")
                            .font(Font.prompt(.regular, size: 16))
                        Spacer()
                    }
                    VStack {
                        HStack {
                            Toggle("All Day", isOn: $toggleAllDay)
                                .tint(Clr.primarySecond)
                                .onChange(of: toggleAllDay) { newValue in
                                    if newValue {
                                       starts = Calendar.current.date(from: DateComponents(hour: 0, minute: 0))!
                                       ends =  Calendar.current.date(from: DateComponents(hour: 23, minute: 59))!
                                    } else {
                                        ends = Calendar.current.date(from: DateComponents(hour: 23, minute: 58))!
                                    }
                                    // Handle the change here
                                }
                                
                        }.padding(.horizontal)
                        if !toggleAllDay {
                            Rectangle()
                                .frame(height: 2.5)
                                .foregroundColor(Clr.primary)
                            HStack {
                                DatePicker("Starts", selection: $starts, displayedComponents: [.hourAndMinute])
                            }.padding(.horizontal)
                            Rectangle()
                                .frame(height: 2.5)
                                .foregroundColor(Clr.primary)
                            HStack {
                                DatePicker("Ends", selection: $ends, displayedComponents: [.hourAndMinute])
                            }.padding(.horizontal)
                        }
                    }
                    .frame(height: toggleAllDay ? 48 : 164)
                    .foregroundColor(Clr.primary)
                    .background(Clr.primaryBackground)
                    .cornerRadius(24)
                    .font(Font.prompt(.regular, size: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Clr.primary, lineWidth: 2.5)
                        )
                    HStack(alignment: .center) {
                        ForEach(Array(0..<7), id: \.self) { index in
                            DayBubble(day: $days[index])
                        }
                    }.frame(height: 56, alignment: .center)
                    .padding(.horizontal)
                    .background(Clr.primaryBackground)
                    .cornerRadius(24)
                    .font(Font.prompt(.regular, size: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Clr.primary, lineWidth: 2.5)
                    )
                }
            }
         
            PrimaryButton(title: "Save Schedule", action: {
                withAnimation {
                    let saveSchedule = Schedule(title: sessionTitle, breaks: toggleBreaks, starts: starts, ends: ends, daysOfWeek: days, appsCount: familyViewModel.appsCount, categoriesCount: familyViewModel.categoriesCount)
                    if mainVM.selectedSchedule.isSuggested {
                        mainVM.user.schedules.append(saveSchedule)
                    } else {
                        if let index = mainVM.user.schedules.firstIndex(where: { $0.id == mainVM.selectedSchedule.id }) {
                            mainVM.user.schedules[index] = saveSchedule
                        }
                    }
                    mainVM.saveData()
                    showAppSession.toggle()
                    mainVM.selectedSchedule = Schedule.templateSchedule
                }
            }, isDisabled: (!isAtLeastOneDaySelected || (familyViewModel.appsCount == 0 && familyViewModel.categoriesCount == 0))).padding(.bottom, 32)
        }.frame(height: toggleAllDay ? 526 : 640)
            .padding(.horizontal, 32)
            .foregroundColor(Clr.primary)
            .background(Clr.primaryBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Clr.primary, lineWidth: 7)
            )
            .cornerRadius(24)
            .animation(.easeInOut(duration: 0.3), value: toggleAllDay)
            .onChange(of: showAppSession) { newValue in
                if newValue {
                    updateData()
                }
            }
            .familyActivityPicker(isPresented: $presentFamilyPicker, selection: $familyViewModel.selectionToDiscourage)
    }
    
    private func updateData() {
        if  mainVM.selectedSchedule.title == "💎 My Schedule" || mainVM.selectedSchedule.isSuggested {
            familyViewModel.appsCount = 0
            familyViewModel.categoriesCount = 0
        } else {
            familyViewModel.restoreBlockedApps()
        }
        sessionTitle = mainVM.selectedSchedule.title
        toggleAllDay = mainVM.selectedSchedule.isAllDay
        toggleBreaks = mainVM.selectedSchedule.breaks
        starts = mainVM.selectedSchedule.starts
        ends = mainVM.selectedSchedule.ends
        days = mainVM.selectedSchedule.daysOfWeek
    }
}

struct DayBubble: View {
    @Binding var day: Day
    //TODO: at least one must be selected
    var body: some View {
        ZStack {
            Circle()
                .fill(day.isSelected ? Clr.primarySecond : Color.gray.opacity(0.5))
                .frame(width: 36, height: 36)
            Text(day.name)
                .font(Font.prompt(.bold, size: 12))
                .foregroundColor(day.isSelected ? .white : .black)
        }.onTapGesture {
                day.isSelected.toggle()
        }



      
    }
}
struct AppScheduleModal_Previews: PreviewProvider {
    static var previews: some View {
        AppScheduleModal(mainVM: MainViewModel(), showAppSession: .constant(false))
    }
}

struct AppSessionModalSelect: View {
    @ObservedObject var mainVM: MainViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Clr.primary)
                .frame(height: 70)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black, lineWidth: 3)
                )
                .cornerRadius(16)
            VStack {
                HStack {
                    Text("difficulty.rawValue")
                        .font(Font.prompt(.medium, size: 20))
                        .padding(.leading, 8)
                        .foregroundColor(Clr.primary)
                    Spacer()
                }.padding(.horizontal, 12)
                HStack {
                    Text("difficulty.description")
                        .font(Font.prompt(.regular, size: 16))
                        .padding(.leading, 8)
                        .foregroundColor(Clr.primary)
                    Spacer()
                }.padding(.horizontal, 12)
            }
        }.onTapGesture {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
}


