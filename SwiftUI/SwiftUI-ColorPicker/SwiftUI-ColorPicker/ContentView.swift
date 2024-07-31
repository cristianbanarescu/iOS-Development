//
//  ContentView.swift
//  SwiftUI-ColorPicker
//
//  Created by Cristian Banarescu on 29.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var pickedColor: Color = .blue
    @State private var textEditorText = "This is a text"
    
    var body: some View {
        VStack(spacing: 30) {
            ColorPicker("Pick a color", selection: $pickedColor) // color picker with just a 'title' (String)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 200)
                .foregroundStyle(pickedColor)
            
            ColorPicker(selection: $pickedColor) { // color picker with custom description
                Text("Custom color picker label/text")
                    .italic()
                    .bold()
                    .font(.system(size: 25))
            }
            
            ColorPicker(selection: $pickedColor, supportsOpacity: false) { // colorpicker with NO opacity enabled; you cannot choose opacity for the color
                Text("Custom color picker label/text; no opacity supported")
                    .italic()
                    .bold()
                    .font(.system(size: 25))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
