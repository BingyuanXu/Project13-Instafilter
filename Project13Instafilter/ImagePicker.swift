//
//  ImagePicker.swift
//  Project13Instafilter
//
//  Created by bingyuan xu on 2020-06-23.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var image: UIImage?
  @Environment(\.presentationMode) var presentionMode
  
  class Coordinator: NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {      //It doesn’t need to be a nested class, but readable
    var parent: ImagePicker //its parent
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let uiImage = info[.originalImage] as? UIImage
      {
        parent.image = uiImage
      }
      
      parent.presentionMode.wrappedValue.dismiss()
      
    }
    
    init(_ parent: ImagePicker) { //把self传进这个class
      self.parent = parent
    }
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
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
