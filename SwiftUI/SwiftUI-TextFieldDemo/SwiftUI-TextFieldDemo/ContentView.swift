//
//  ContentView.swift
//  SwiftUI-TextFieldDemo
//
//  Created by Cristian Banarescu on 17.02.2024.
//

import SwiftUI

/*
 bind the TextField to a variable (via the TextField's init), in order to get or set the text on it
 */

struct ContentView: View {
    @State private var textfieldText: String = ""
    @State private var toggleOn: Bool = false
    @State private var textEditorText: String = "This is some text"
    
    var body: some View {
        VStack {
            // use the first param as the placeholder of the TextField
            TextField("placeholder", text: $textfieldText)
                .textFieldStyle(.roundedBorder)
            
            TextField("alignment leading", text: $textfieldText)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.leading)
            
            TextField("alignment center", text: $textfieldText)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
            
            TextField("alignment trailing", text: $textfieldText)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
            
            TextField("Bigger font", text: $textfieldText)
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle)
            
            // pay attention to NOT add a textFieldStyle on the TextField when customising it
            TextField("Customised background", text: $textfieldText)
                .padding()
                .background(RoundedRectangle(cornerRadius: 90).foregroundStyle(.red.opacity(0.4)))
            
            TextField("Customised border", text: $textfieldText)
                .padding()
                .font(.headline)
                .overlay {
                    RoundedRectangle(cornerRadius: 90).stroke(lineWidth: 9)
                }
            
            ZStack(alignment: .leading) {
                if textfieldText.isEmpty {
                    Text("Custom placeholder")
                        .bold()
                        .foregroundStyle(.black)
                        .italic()
                        .padding(.leading, 10)
                }
                TextField("", text: $textfieldText)
                    .padding(.leading, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 90).stroke(lineWidth: 2)
                    }
            }
            
            TextField("Enter phone number", text: $textfieldText)
                .padding()
                .keyboardType(.phonePad)
            
            TextField("No autocorrection", text: $textfieldText)
                .padding()
                .autocorrectionDisabled()
            
            Toggle(isOn: $toggleOn, label: {
                Text("Toggle textfield text")
            })
            .tint(.red)
            
            TextEditor(text: $textEditorText)
                .scrollContentBackground(.hidden) // set this in order to be able to set background color
                .background(.red)
        }
        .padding()
        .onChange(of: toggleOn) {
            textfieldText = toggleOn ? "Random" : ""
        }
    }
}

#Preview {
    ContentView()
}
