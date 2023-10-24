//
//  RulesScreen.swift
//  Halo
//
//  Created by Dante Kim on 10/7/23.
//

import SwiftUI

struct RulesScreen: View {
    @ObservedObject var mainVM: MainViewModel
    @State private var showSchedules = 0
    @Binding var addAppLimit: Bool
    @Binding var addAppSchedule: Bool

    var body: some View {
        // TODO: trigger session if time and day is right now.
        ZStack {
            VStack(spacing: 12) {
                TwoOptionMenu(selectedOption: $showSchedules, options: [MenuOption(title: "Schedules", action: {
                    showSchedules = 0
                }), MenuOption(title: "Limits", action: {
                    showSchedules = 1
                })]).padding(.horizontal, Constants.paddingLarge)
                if showSchedules == 0 {
                    VStack(alignment: .leading, spacing: 8) {
                        PrimaryButton(img: Image(systemName: "plus"), title: "Add App Schedule") {
                            withAnimation {
                                mainVM.selectedSchedule = Schedule.templateSchedule
                                addAppSchedule = true
                            }
                        }.padding(.vertical, 16)
                            .padding(.horizontal, Constants.paddingLarge)
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 8) {
                                if !mainVM.user.schedules.isEmpty {
                                    Text("Today")
                                        .font(Font.prompt(.medium, size: 20))
                                        .foregroundColor(Color.black.opacity(0.5))
                                }
                                
                                if !exampleUser.schedules.isEmpty {
                                    //ScheduleCard(title: "💎 My Schedule", isActive: true)
                                }
                                
                                ForEach(Array(mainVM.user.schedules.reversed().enumerated()), id: \.element.id) { index, schedule in                                    ScheduleCard(schedule: schedule) {
                                        withAnimation {
                                            mainVM.selectedSchedule = schedule
                                            addAppSchedule.toggle()
                                        }
                                    }.padding(.top, index == 0 ? 0 : 12)
                                }
                                Text("Suggested")
                                    .font(Font.prompt(.medium, size: 20))
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .padding(.top)
                                ForEach(Schedule.suggestedSchedules)   { schedule in
                                    ScheduleCard(schedule: schedule) {
                                        withAnimation {
                                            mainVM.selectedSchedule = schedule
                                            addAppSchedule.toggle()
                                        }
                                    }
                                }
                            }.padding(.horizontal, Constants.paddingLarge)
                        }
                        .cornerRadius(12)
                    }.foregroundColor(Clr.primary)
                } else {
                    PrimaryButton(img: Image(systemName: "plus"), title: "Add App Limit") {
                        withAnimation {
                            addAppLimit = true
                        }
                    }.padding(.vertical, 16)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Today")
                            .font(Font.prompt(.medium, size: 20))
                            .foregroundColor(Color.black.opacity(0.5))
                        LimitCard(isActive: true)
                        Text("Suggested")
                            .font(Font.prompt(.medium, size: 20))
                            .foregroundColor(Color.black.opacity(0.5))
                            .padding(.top)
                        LimitCard(isActive: false, isSuggested: true)
                    }.padding(.horizontal, Constants.paddingLarge)
                }
                            
                Spacer()
            }
        }
    }
}

#Preview {
    RulesScreen(mainVM: MainViewModel(), addAppLimit: .constant(false), addAppSchedule: .constant(false))
}

struct LimitCard: View {
    var isActive: Bool
    var isSuggested: Bool = false
    
    var body: some View {
        BoxCard(size: isActive ? 5 : 6) {
            GeometryReader { g in

            VStack(alignment: .leading, spacing: 16) {
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("⏲️ My Limit")
                            .font(Font.prompt(.semiBold, size: 20))
                            .foregroundColor(Clr.primary)
                        Spacer()
                        if isActive {
                            Capsule()
                                .fill(Clr.primarySecond.opacity(0.5))
                                .overlay(
                                    HStack {
                                        Text("Active")
                                            .font(Font.prompt(.medium, size: 16))
                                            .foregroundColor(Clr.primary)
                                    }
                                )
                                .frame(width: 72, height: 32)
                        } else if isSuggested {
                            Capsule()
                                .fill(Clr.primary)
                                .overlay(
                                    HStack {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 12)
                                            .bold()
                                        Text("Add")
                                            .font(Font.prompt(.medium, size: 16))
                                    }.foregroundColor(.white)
                                )
                                .frame(width: 80, height: 28)
                        }
                        
                        if !isSuggested {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10)
                                .foregroundStyle(Color.black.opacity(0.5))
                        }
                    }
                    HStack {
                        Image(systemName: "repeat")
                            .foregroundColor(Color.black.opacity(0.5))
                        Text("Weekdays")
                            .font(Font.prompt(.medium, size: 16))
                            .foregroundColor(Color.black.opacity(0.5))
                    }
                }

                if !isSuggested {
                    HStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10)
                        HStack(spacing: 4) {
                            Image(systemName: "square.grid.2x2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16)
                            Text("1")
                                .font(Font.prompt(.regular, size: 16))
                        }
                        Spacer()
                        Text("13min/30min")
                            .font(Font.prompt(.regular, size: 16))
                            
                    }.foregroundColor(Color.black.opacity(0.5))
                    HStack {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: g.size.width, alignment: .leading)
                                .cornerRadius(12)
                            Rectangle()
                                .fill(Clr.primarySecond)
                                .frame(width: g.size.width * (13/30), height: 12, alignment: .leading)
                                .animation(.linear, value: (13/30))
                                .cornerRadius(12)
                        }
                    
                    }.frame(width: g.size.width / 1.2, alignment: .leading)
                    Spacer()
                } else {
                        HStack(spacing: 8) {
                            Text("When")
                            VStack {
                                Image(systemName: "hourglass")
                            }.frame(width: 20, height: 20)
                                .foregroundColor(Color.white)
                                .background(Clr.dndPurple)
                                .cornerRadius(4)
                            Text("exceeds x mins")
                                .foregroundColor(.white)
                                .padding(.horizontal, 2)
                                .background(Clr.dndPurple)
                                .italic()
                                .cornerRadius(4)
                            Image(systemName: "lock.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10)
                            Text("apps")
                        }
                    Spacer()
                }
            }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
        }
    }
}
struct ScheduleCard: View {
    var schedule: Schedule
    var action: () -> ()

    
    var body: some View {
        BoxCard(size: schedule.isActive ? 5.5 : schedule.isSuggested ? 4.5 : 6) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("\(schedule.title)")
                            .font(Font.prompt(.semiBold, size: 20))
                            .foregroundColor(Clr.primary)
                        Spacer()
                        if schedule.isActive {
                            Capsule()
                                .fill(Clr.primarySecond.opacity(0.5))
                                .overlay(
                                    HStack {
                                        Text("Active")
                                            .font(Font.prompt(.medium, size: 16))
                                            .foregroundColor(Clr.primary)
                                    }
                                )
                                .frame(width: 72, height: 32)
                        } else if schedule.isSuggested {
                            Capsule()
                                .fill(Clr.primary)
                                .overlay(
                                    HStack {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 12)
                                            .bold()
                                        Text("Add")
                                            .font(Font.prompt(.medium, size: 16))
                                    }.foregroundColor(.white)
                                )
                                .frame(width: 80, height: 28)
                        }
                        
                        if !schedule.isSuggested {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10)
                                .foregroundStyle(Color.black.opacity(0.5))
                        }
                    }
                    HStack {
                        Text("\(schedule.starts.toString()) - \(schedule.ends.toString())")
                            .font(Font.prompt(.medium, size: 16))
                            .foregroundColor(schedule.isActive ? Clr.primaryThird : Color.black.opacity(0.5))
                        Text("| \(schedule.dayFormatted)")
                            .font(Font.prompt(.medium, size: 16))
                            .foregroundColor(Color.black.opacity(0.5))
                    }
                }
                
                if !schedule.isSuggested {
                    HStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10)
                        if schedule.categoriesCount > 0 {
                            HStack(spacing: 4) {
                                Image(systemName: "square.grid.2x2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16)
                                Text("\(schedule.categoriesCount)")
                                    .font(Font.prompt(.regular, size: 16))
                            }
                        }
                        if schedule.appsCount > 0 {
                            HStack(spacing: 4) {
                                Image(systemName: "apps.iphone")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                                Text("\(schedule.appsCount)")
                                    .font(Font.prompt(.regular, size: 16))
                            }
                        }
                        Spacer()
                        if schedule.isActive  {
                            Capsule()
                                .fill(Clr.primary)
                                .overlay(
                                    HStack {
                                        Image(systemName: "pause.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 10)
                                        Text("Take a break")
                                            .font(Font.prompt(.medium, size: 16))
                                    }.foregroundColor(.white)
                                )
                                .frame(width: 156, height: 32)
                        }
                    }.foregroundColor(Color.black.opacity(0.5))
                } else {
                    Text("\(schedule.description)")
                        .font(Font.prompt(.regular, size: 16))
                        .foregroundColor(Color.black.opacity(0.5))
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
        }.onTapGesture {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            action()
        }
    }
}
