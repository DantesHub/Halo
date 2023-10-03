//
//  BoxCard.swift
//  Halo
//
//  Created by Dante Kim on 8/31/23.
//

import SwiftUI

struct BoxCard<Content: View>: View {
    var size: CGFloat
    let children: Content
    
    init(size: CGFloat, @ViewBuilder content: () -> Content) {
        self.size = size
        self.children = content()
    }
    
    
    @ViewBuilder var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .fill(Clr.primaryBackground)
                .primaryShadow()
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .stroke(.black, lineWidth: 4)
            VStack {
                children
            }.clipShape(RoundedRectangle(cornerRadius: Constants.cardCornerRadius))
        }
        .frame(height: UIScreen.main.bounds.height / size)
    }
}

enum BoxSize: CGFloat  {
    case small = 6.5
    case big = 3.5
    case option = 14
}
