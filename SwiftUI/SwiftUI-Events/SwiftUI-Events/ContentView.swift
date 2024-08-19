//
//  ContentView.swift
//  SwiftUI-Events
//
//  Created by Cristian Banarescu on 19.08.2024.
//

import SwiftUI

/*
 
 - use the .onReceive modifier to add an action to your View to perform when it detects data emitted by a publisher
 - use the .onChange modifier to detect when some value changes
 
 */

struct ContentView: View {
    @State var myValue: Int = 0
    
    var body: some View {
        VStack {
            Button("Change value") {
                myValue += 1
            }
            
            Text("\(myValue)")
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { output in
            print("app didBecomeActive")
            print("user info: \(output.userInfo ?? [:])")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { output in
            print("resigning active")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            print("didEnterBackgroundNotification app")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            print("changed orientation")
        }
        .onChange(of: myValue) { oldValue, newValue in
            print(oldValue)
            print(newValue)
        }
    }
}

#Preview {
    ContentView()
}
