//
//  UIDevice+Orientation.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 25.02.2023.
//

import SwiftUI

extension UIDevice {
    var isPortraitOrientation: Bool {
        switch orientation {
        case .unknown, .portrait, .portraitUpsideDown:
            return true
        case .landscapeLeft, .landscapeRight:
            return false
        default:
            return true
        }
    }
}
