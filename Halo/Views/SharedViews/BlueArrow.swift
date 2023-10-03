//
//  BlueArrow.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct BlueArrow: View {
    var body: some View {
        Image(systemName: "chevron.right.circle.fill")
            .resizable()
            .foregroundColor(Clr.primaryThird)
            .frame(width: 28, height: 28)
    }
}

struct BlueArrow_Previews: PreviewProvider {
    static var previews: some View {
        BlueArrow()
    }
}
