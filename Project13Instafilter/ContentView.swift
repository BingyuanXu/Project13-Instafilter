//
//  ContentView.swift
//  Project13Instafilter
//
//  Created by bingyuan xu on 2020-06-20.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var blurAmount: CGFloat = 0
  
  var body: some View {
    let blur = Binding<CGFloat>(
      get: {
        self.blurAmount
        
    },
      set: {
          print("New value is \(self.blurAmount)")
        self.blurAmount = $0     

    })

    return VStack {
      Text("Hello, World!")
        .blur(radius: blurAmount)
      
      Slider(value: blur, in: 0...20)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
