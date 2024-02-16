//
//  ContentView.swift
//  SwiftUI-TextDemo
//
//  Created by Cristian Banarescu on 17.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // normally this text fits 3 lines on iPhone 15 Pro
            Text("Hello, Swift! Swift is a powerful and elegant programming language developed by Apple for iOS, macOS, watchOS, and tvOS development.")
                .lineLimit(2) // force it to 2 lines
                .font(.largeTitle)
            
            Text("Footnote text ")
                .font(.footnote)
            
            Text("Bolded")
                .fontWeight(.bold)
            
            Text("Italic footnote")
                .font(.footnote)
                .italic()
            
            Text("Striked")
                .strikethrough() // (color: .red) can also use another color for the strikethrough
            
            Text("Red")
                .foregroundStyle(.red)
            
            Text("underlined")
                .underline()
            
            Text("Some long text that will need tightening and getting text smaller")
                .lineLimit(1)
                .minimumScaleFactor(0.5) // scale text to 50% down of its original size so that the text fits into 1 line
                        
            Text("Hello, Swift! Text with bigger line spacing. Swift is a powerful and elegant programming language developed by Apple for iOS, macOS, watchOS, and tvOS development.")
                .lineSpacing(30)
                        
            Text("Aligned left when text spans on multiple lines")
                .font(.title)
                .multilineTextAlignment(.leading)
            
            Text("Aligned right when text spans on multiple lines")
                .font(.title)
                .multilineTextAlignment(.trailing)
            
            Text("Aligned center when text spans on multiple lines")
                .font(.title)
                .multilineTextAlignment(.center)
            
            Text("some very long text that will get truncated at middle")
                .lineLimit(1)
                .truncationMode(.middle)

            Text("some very long text that will get truncated at head")
                .lineLimit(1)
                .truncationMode(.head)
            
            Text("some very long text that will get truncated at tail")
                .lineLimit(1)
                .truncationMode(.tail)
            
            // Combine text just using '+'
            Text("Bold ")
                .fontWeight(.bold)
            + Text("Italic ")
                .italic()
            + Text("Striked")
                .strikethrough()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
