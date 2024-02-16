//
//  ContentView.swift
//  SwiftUI-TabViewDemo
//
//  Created by Cristian Banarescu on 13.02.2024.
//

import SwiftUI

/*
 TabView - container with child views inside it; Child views are just other individual screens
 
 Use the .tabItem modifier on a View (View which is already added in the TabView container) in order to create a 'button' on the TabView
 
 To programatically change the tab, use a binding variable and use this binding inside the TabView's init selection parameter; Pay attention that you need to set a tag to all the tabItems (even if you do not navigate to all of them), otherwise the 'programatic navigation' does not work
 
 Use the .tint() modifier to apply a custom selection color on the TabView
 
 Apparently, after 4 tab items (iPhone 15 Pro), SwiftUI will add a 'More' tabItem in which it will include the other tabItems that did not fit in the screen
 */

struct ContentView: View {
    @State var selectedTab = 1
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                VStack {
                    Text("screen 1")
                    
                    Button("Go to tab 3") {
                        selectedTab = 3
                    }
                    .tint(.blue)
                }
                .tabItem {
                    Text("Screen 1")
                }
                .tag(1)
                .badge(1) // tab with an Int badge
                
                Text("screen 2")
                    .tabItem { 
                        Text("Screen 2")
                    }
                    .tag(2)
                
                Text("Screen 3")
                    .tabItem { // here, the order of Text and Image does not matter; SwiftUI will arrange them always as the Image above the Text
                        Text("Square down")
                        Image(systemName: "square.and.arrow.down.fill")
                    }
                    .tag(3)
                
                Text("screen 4")
                    .tabItem {
                        Text("Screen 4")
                    }
                    .tag(4)
                
                // apparently, after 4 tab items (iPhone 15 Pro), SwiftUI will add a 'More' tabItem in which it will include the other tabItems that did not fit in the screen
                
                Text("screen 5")
                    .tabItem {
                        Text("Screen 5")
                    }
                    .tag(5)
                
                Text("screen 6")
                    .tabItem {
                        Text("Screen 6")
                    }
                    .tag(6)
            }
            .tint(.orange) // apply custom selection color
        }
    }
    
    init(selectedTab: Int = 1) {
        self.selectedTab = selectedTab
        
        UITabBar.appearance().backgroundColor = UIColor(red: 19/255.0, green: 232/255.0, blue: 123/255.0, alpha: 0.3) // can use this hack to change the backgroundColor of the tabbar
    }
}

#Preview {
    ContentView()
}
