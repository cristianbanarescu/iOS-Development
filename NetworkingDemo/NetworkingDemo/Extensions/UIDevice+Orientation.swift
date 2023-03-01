//
//  UIDevice+Orientation.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 25.02.2023.
//

import SwiftUI

extension UIDeviceOrientation {
    var isPortraitOrientation: Bool {
        switch self {
        case .portrait, .portraitUpsideDown:
            return true
        case .landscapeLeft, .landscapeRight:
            return false
        case .unknown:
            return false 
        default:
            return true
        }
    }
}
