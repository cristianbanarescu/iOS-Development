//
//  ContentView.swift
//  CocoaPodsDemo
//
//  Created by Cristian Banarescu on 07.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Lottie animation:")
            LottieView(fileName: "9501-icons-package-setting")
                .frame(height: 300)
            Text("Credits to https://lottiefiles.com/9501-icons-package-setting")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
