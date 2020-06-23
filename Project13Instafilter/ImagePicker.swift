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
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
  }
  
  typealias UIViewControllerType = UIImagePickerController
}
