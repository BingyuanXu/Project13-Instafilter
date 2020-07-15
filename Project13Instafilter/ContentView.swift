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
  @State private var filterIntensity = 0.5
  @State private var showImagePicker = false
  @State private var inputImage: UIImage?
  @State private var currentFilter: CIFilter = CIFilter.sepiaTone() //不写类型的话，这个变量 confirm CISepiaTone protocol
  // we’re saying that the filter must be a CIFilter but doesn’t have to conform to CISepiaTone any more.
  @State private var showingFilterSheet = false
  let context = CIContext();
  
  
  class ImageSaver: NSObject {    //因为这个class给confirm nsobjcet 所以不能写在contentView里边
      func writeToPhotoAlbum(image: UIImage) {
          UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
      }

      @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
          print("Save finished!")
      }
  }

  
  func setFilter(_ filter: CIFilter)  {
    currentFilter = filter
    loadImage()
  }
  
  
  func applyProcessing() {
    //    currentFilter.intensity = Float(filterIntensity)
    //    在上边改了类型为CIFilter 后，不再自动comfirm to CISepiaTone protocol ,里边就没有 intensity这个属性了， 所以给改成下边这个
//    currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
    
    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
    
    
    guard let outputImage = currentFilter.outputImage else { return }
    
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
    }
  }
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    
    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    
    applyProcessing()
  }
  
  var body: some View {
    
    let intensity = Binding<Double>(
      get: {
        self.filterIntensity
    },
      set: {
        self.filterIntensity = $0
        self.applyProcessing()
    }
    )
    
    return NavigationView {  //Now that there is some logic inside the body property, you must place return
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
          Slider(value: intensity)
        }
        .padding(.vertical)
        
        HStack {
          Button("Change Filter") {
            self.showingFilterSheet = true
          }
          .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Select a filter"), buttons: [
              .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
              .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
              .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
              .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
              .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
              .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
              .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
              .cancel()
            ])
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
        ImagePicker(image: self.$inputImage)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
