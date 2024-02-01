//
//  ContentView.swift
//  SwiftUI-SecureFieldDemo
//
//  Created by Cristian Banarescu on 01.02.2024.
//

import SwiftUI

/*
 Apparently if you want to unhide the text in the SecureField, you can't. You will need to use a combination of SecureField and TextField; if 'hideText' Bool is true > use SecureField; if 'hideText' == false > use TextField
 */

struct ContentView: View {
    @State private var text: String = "" // Use this to get or set text inside the SecureField
    @State private var hideText = true
    
    var body: some View {
        VStack {
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 50)
                .foregroundStyle(.red.opacity(0.4))
                .overlay {
                    if hideText {
                        SecureField(text: $text) { // use to bind the text var to the SecureField in order to set or get the text value of the field
                            Text("hidden") // placeholder for SecureField
                                .font(.title2)
                        }
                        .padding()
                        .foregroundStyle(.black)
                    } else {
                        TextField(text: $text) {
                            Text("hidden") // placeholder for SecureField
                                .font(.title2)
                        }
                        .padding()
                        .foregroundStyle(.black)
                    }
                }
            
            Spacer()
            
            Button("Set random text inside SecureField") {
                text = String(UUID().uuidString.prefix(10))
            }
            .font(.headline)
            .buttonStyle(.borderedProminent)
            
            Button("Show/Hide chars from SecureField") {
                hideText.toggle()
            }
            .tint(.orange)
            .font(.headline)
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
