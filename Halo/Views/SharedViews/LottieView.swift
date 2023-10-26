//
//  LottieView.swift
//  Halo
//
//  Created by Dante Kim on 10/3/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    let loopMode: LottieLoopMode
    let animation: String
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: animation)
        
        // Get the total number of frames in the animation
        let endFrame = animationView.animation?.endFrame ?? 0
        
        // Play the animation from the start to the end frame, twice
        animationView.play(fromFrame: 0, toFrame: endFrame * 2, loopMode: .playOnce) { finished in
            // Handle completion if needed
        }
        
        animationView.contentMode = .scaleAspectFit
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([animationView.heightAnchor.constraint(equalTo: view.heightAnchor), animationView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        
        return view
    }
}
