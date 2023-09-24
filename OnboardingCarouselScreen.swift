//
//  OnboardingCarouselScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/23/23.
//

import SwiftUI

struct OnboardingCarouselScreen: View {
    var body: some View {
        VStack {
            Img.middleAngels
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct OnboardingCarouselScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCarouselScreen()
    }
}
