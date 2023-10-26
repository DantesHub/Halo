//
//  ShopScreen.swift
//  Halo
//
//  Created by Dante Kim on 10/3/23.
//

import SwiftUI

struct ShopScreen: View {
    
    // MARK: - Properties
    @Binding var isPresented: Bool
    @State private var showModal = false
    @State private var animateBox = false
    @ObservedObject var mainVM: MainViewModel
    // MARK: - Body
    @State private var animateBoxes: [HaloBox] = [HaloBox(name: "Tissue Box", img: Img.haloboxes6, price: 100), HaloBox(name: "Banana Milk", img: Img.haloboxes1, price: 1000), HaloBox(name: "Jack in the Box", img: Img.haloboxes2, price: 400), HaloBox(name: "Toolbox", img: Img.haloboxes3, price: 300), HaloBox(name: "Flower Box", img: Img.haloboxes4, price: 200), HaloBox(name: "Black Lava", img: Img.haloboxes5, price: 250)]// Assuming 12 boxes in total
    @State private var animateBoxes2: [HaloBox] = [HaloBox(name: "Tissue Box", img: Img.haloboxes7, price: 100), HaloBox(name: "Banana Milk", img: Img.haloboxes8, price: 1000), HaloBox(name: "Jack in the Box", img: Img.haloboxes9, price: 400), HaloBox(name: "Toolbox", img: Img.haloboxes10, price: 300), HaloBox(name: "Flower Box", img: Img.haloboxes11, price: 200), HaloBox(name: "Black Lava", img: Img.haloboxes12, price: 250)]// Assuming 12 boxes in total


    var body: some View {
        ZStack {
            GeometryReader { g in
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "arrow.backward.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 32)
                            .onTapGesture {
                                UIImpactFeedbackGenerator(style: .light)
                                    .impactOccurred()
                                withAnimation {
                                    isPresented.toggle()
                                }
                            }
                        Spacer()
                        HStack {
                            Img.haloCoin
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 32)
                            Text("\(mainVM.user.coins)")
                                .font(Font.prompt(.medium, size: 24))
                        }
                    }.padding(.horizontal, 36)
                    ScrollView(showsIndicators: false) {
                                // First Column (Slightly Bigger)
                                VStack(alignment: .leading, spacing: -10) {
                                    // Add your badge plants here for the first column
                                    HStack(spacing: 32) {
                                        VStack(alignment: .leading, spacing: 24) {
                                            Text("Guardian Shop 🛍️ ")
                                                .foregroundColor(Clr.primary)
                                                .font(Font.prompt(.medium, size: 24))
                                                .offset(x: 8, y: 8)
                                            ForEach(0..<6, id: \.self) { index in
                                                BoxCard(size: BoxSize.tile.rawValue) {
                                                    VStack(spacing: -12) {
                                                        Text(animateBoxes[index].name)
                                                            .foregroundColor(Clr.primary)
                                                            .font(Font.prompt(.medium, size: 16))
                                                        animateBoxes[index].img
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(height: 160)
                                                            .rotationEffect(.degrees(animateBoxes[index].toggling ? 8 : -4))
                                                            .offset(y: animateBoxes[index].toggling ? -7 : 7)
                                                            .animation(Animation.easeInOut(duration: 1)
                                                                .repeatForever(autoreverses: true), value: animateBoxes[index].toggling)
                                                            .onAppear() {
                                                                self.animateBoxes[index].toggling.toggle()
                                                            }
                                                        HStack {
                                                            Text(String(animateBoxes[index].price))
                                                                .foregroundColor(Clr.primary)
                                                                .font(Font.prompt(.italic, size: 16))
                                                            Img.haloCoin
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(height: 16)
                                                        }
                                                    }
                                                }
                                            }
                                        }.padding(.top)
                                            .offset(y: 16)
                                        VStack(alignment: .leading, spacing: 24) {
                                            // Add your badge plants here for the second column
                                            ForEach(0..<6, id: \.self) { index in
                                                BoxCard(size: BoxSize.tile.rawValue) {
                                                    VStack(spacing: -12) {
                                                        Text(animateBoxes2[index].name)
                                                            .foregroundColor(Clr.primary)
                                                            .font(Font.prompt(.medium, size: 16))
                                                        animateBoxes2[index].img
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(height: 160)
                                                            .rotationEffect(.degrees(animateBoxes[index].toggling ? 8 : -4))
                                                            .offset(y: animateBoxes2[index].toggling ? -7 : 7)
                                                            .animation(Animation.easeInOut(duration: 1)
                                                                .repeatForever(autoreverses: true), value: animateBoxes2[index].toggling)
                                                            .onAppear() {
                                                                self.animateBoxes2[index].toggling.toggle()
                                                            }
                                                        HStack {
                                                            Text(String(animateBoxes2[index].price))
                                                                .foregroundColor(Clr.primary)
                                                                .font(Font.prompt(.italic, size: 16))
                                                            Img.haloCoin
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(height: 16)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }.padding(.horizontal, 32)
                                }
                                .frame(width: g.size.width)
                                
                                // Second Column (Slightly Smaller)
                                                          
                        }
                    }
                }
            }
            .padding(.top)
        }
}

// ... (Rest of the code remains unchanged)

struct ShopScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShopScreen(isPresented: .constant(false), mainVM: MainViewModel())
    }
}

struct HaloBox {
    var name: String
    var img: Image
    var price: Int
    var toggling: Bool = false
}
