//
//  ContentView.swift
//  Project13Instafilter
//
//  Created by bingyuan xu on 2020-06-20.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
  @State private var image: Image?
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    
    image = Image(uiImage: inputImage)
  }
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
      Button("Select Image") {
        self.showingImagePicker = true
      }
    }
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
      ImagePicker(image: self.$inputImage)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
