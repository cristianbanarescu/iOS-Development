//
//  ContentView.swift
//  SwiftUI-ButtonDemo
//
//  Created by Cristian Banarescu on 28.12.2023.
//

import SwiftUI

/*
 How to create Buttons using different initializers/configurations
 */

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Different ways of creating a button:")
                .font(.title)
            
            GeometryReader { proxy in
                VStack(spacing: 30) {
                    Button("Button with just text") {
                        // action of the button
                    }
                    
                    Button(action: {
                        // action of the button
                    }, label: {
                        Text("Button with text - 1")
                        Text("Button with text - 2")
                    })
                    
                    Button(role: .destructive) {
                        // action of the button
                    } label: {
                        Text("Button with role destructive - ButtonRole")
                    }
                    
                    Button(role: .cancel) {
                        // action of the button
                    } label: {
                        Text("Button with role cancel - ButtonRole")
                    }
                    
                    Button("Button with text and SF image", systemImage: "square.and.arrow.up.circle") {
                        // action of the button
                    }
                    
                    Button(action: {
                        // action of the button
                    }, label: {
                        Image(systemName: "square.and.arrow.up.circle")
                            .imageScale(.large)
                        Text("Button created with custom views inside + button style")
                    })
                    .font(.title3)
                    .buttonStyle(.borderedProminent)
                    //            .buttonBorderShape(.capsule)
                    // buttonBorderShape works only on bordered buttons (bordered or borderedProminent); helpful to set a shape for the button
                    
                    Button(action: {
                        // action of the button
                    }, label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up.circle")
                                .imageScale(.large)
                            Text("Button created with custom views inside - with background")
                        }
                        .padding()
                    })
                    .font(.title3)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.blue)
                    }
                    
                    Button(action: {
                        // action of the button
                    }, label: {
                        Image(.closeX)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    })
                }
                .frame(width: proxy.size.width)
                .padding(.vertical, 30)
                .background(.orange.opacity(0.3))
            }
        }
    }
}

#Preview {
    ContentView()
}
