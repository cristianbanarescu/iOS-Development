//
//  ContentView.swift
//  SwiftUI-PhotoPicker
//
//  Created by Cristian Banarescu on 17.06.2024.
//

import SwiftUI

/// A SwiftUI View that will present a `UIViewControllerRepresentable` View which handles user interaction with a UIKit `UIImagePickerController`. User can choose a photo or cancel (not choose anything)
struct ContentView: View {
        
    @State var selectedPhoto: Image?
    @State var pickerViewPresented: Bool = false
    
    var body: some View {
        VStack {
            Button("Choose photo") {
                pickerViewPresented.toggle()
            }
            selectedPhoto?
                .resizable()
                .scaledToFit()
        }
        .padding()
        .sheet(isPresented: $pickerViewPresented) {
            PhotoPickerView(selectedImage: $selectedPhoto, isShown: $pickerViewPresented)
        }
    }
}

#Preview {
    ContentView()
}
