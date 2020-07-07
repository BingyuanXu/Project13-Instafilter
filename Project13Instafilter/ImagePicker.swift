//
//  ImagePicker.swift
//  Project13Instafilter
//
//  Created by bingyuan xu on 2020-06-23.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  @Environment(\.presentationMode) var presentationMode
  @Binding var image: UIImage?
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker
      
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let uiImage = info[.originalImage] as? UIImage {
        parent.image = uiImage
      }
      
      parent.presentationMode.wrappedValue.dismiss()
    }
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
  }
  
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
  }
  
  typealias UIViewControllerType = UIImagePickerController
}
