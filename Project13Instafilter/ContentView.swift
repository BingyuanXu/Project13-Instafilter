//
//  ContentView.swift
//  Project13Instafilter
//
//  Created by bingyuan xu on 2020-06-20.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var image: Image?
  @State private var filterIntensity = 0.5
  @State private var showImagePicker = false
  @State private var imputImage: UIImage?
  
  func loadImage() {
    guard let inputImage = imputImage else { return }
    
    image = Image(uiImage: inputImage)
    
  }
  
  var body: some View {
    NavigationView {
      VStack {
        ZStack {
          Rectangle()
            .fill(Color.secondary)
          
          if image != nil {
            image?
              .resizable()
              .scaledToFit()
          } else {
            Text("Tap here to select a image")
              .foregroundColor(.white)
              .font(.headline)
          }
          
        }
        .onTapGesture {
          self.showImagePicker = true
        }
        
        HStack {
          Text("Intensity")
          Slider(value: self.$filterIntensity)
        }
        .padding(.vertical)
        
        HStack {
          Button("Change Filter") {
            // change filter
          }
          
          Spacer()
          
          Button("Save") {
            // save the image
          }
        }
      }
      .padding([.leading, .bottom, .trailing])
      .navigationBarTitle("Instafilter")
      .sheet(isPresented: $showImagePicker, onDismiss: loadImage){
        ImagePicker(image: self.$imputImage)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
