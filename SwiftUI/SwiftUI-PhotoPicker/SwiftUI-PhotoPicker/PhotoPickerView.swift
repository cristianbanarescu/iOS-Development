//
//  PhotoPickerView.swift
//  SwiftUI-PhotoPicker
//
//  Created by Cristian Banarescu on 17.06.2024.
//

import SwiftUI

struct PhotoPickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: Image?
    @Binding var isShown: Bool
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var selectedImage: Image?
        @Binding var isShown: Bool
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            selectedImage = Image(uiImage: image)
            isShown = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
        
        init(selectedImage: Binding<Image?>, isShown: Binding<Bool>) {
            self._selectedImage = selectedImage
            self._isShown = isShown
        }
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: $selectedImage, isShown: $isShown)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
}
