//
//  UIDevice+Extensions.swift
//  Halo
//
//  Created by Dante Kim on 8/31/23.
//

import Foundation
import UIKit

extension UIDevice {
    /// Returns `true` if the device has a notch
    static var hasNotch: Bool {
            if #available(iOS 13.0, *) {
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                guard let window = windowScene?.windows.first else { return false }
                
                return window.safeAreaInsets.top > 20
            }
            
            if #available(iOS 11.0, *) {
                let top = UIApplication.shared.windows[0].safeAreaInsets.top
                return top > 20
            } else {
                // Fallback on earlier versions
                return false
            }
        }
    
        static var isIPad: Bool {
            UIDevice.current.userInterfaceIdiom == .pad
        }
        
    static var isSmall: Bool {
        return !UIDevice.hasNotch && !UIDevice.isIPad
    }
            
}
