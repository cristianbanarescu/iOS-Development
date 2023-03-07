//
//  LottieView.swift
//  CocoaPodsDemo
//
//  Created by Cristian Banarescu on 07.03.2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    let fileName: String
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()

        let animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.animation = .named(fileName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
