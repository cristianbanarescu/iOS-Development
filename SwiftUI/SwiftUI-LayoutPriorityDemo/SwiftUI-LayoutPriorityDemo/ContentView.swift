//
//  ContentView.swift
//  SwiftUI-LayoutPriorityDemo
//
//  Created by Cristian Banarescu on 21.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Text("Hello")
//                .layoutPriority(2)
            // if uncommenting the above line, the "Hello" text will get more space compared to the "world!" text and the text will not span on multiple lines.
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("world!")
                .layoutPriority(1)
            // if you comment the above line, both Texts will expand on 2 lines; right now, this view gets priority compared to the one above and the text does not span on multiple lines
        }
        .frame(width: 200)
        .padding()
        .font(.largeTitle)
        .background(.red)
    }
}

#Preview {
    ContentView()
}
