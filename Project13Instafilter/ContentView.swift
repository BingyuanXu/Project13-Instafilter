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
  
  func loadImage(){
    guard let inputImage = UIImage(systemName:"moon") else {return }
    
    let beginImage = CIImage(image: inputImage)
    let context = CIContext()
    
    let currentFilter = CIFilter.sepiaTone()
    currentFilter.inputImage = beginImage
    currentFilter.intensity = 1
    
//    let currentFilter = CIFilter.pixellate()
//    currentFilter.inputImage = beginImage
//    currentFilter.scale = 100
    
//    let currentFilter = CIFilter.crystallize()
//    currentFilter.inputImage = beginImage
//    currentFilter.radius = 200
    
//    let currentFilter = CIFilter.crystallize()
//    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//    currentFilter.radius = 200
//    
//    guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
//    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//    currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
//    currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
   
    guard let outputImage = currentFilter.outputImage else {return}
    
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      // convert that to a UIImage
      let uiImage = UIImage(cgImage: cgimg)
      
      // and convert that to a SwiftUI image
      image = Image(uiImage: uiImage)
    }
  }
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
    }
    .onAppear(perform: loadImage)
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
