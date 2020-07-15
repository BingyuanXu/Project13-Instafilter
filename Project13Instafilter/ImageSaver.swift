//
//  ImageSaver.swift
//  Project13Instafilter
//
//  Created by bingyuan xu on 2020-07-14.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {    //因为这个class给confirm nsobjcet 所以不能写在contentView里边
  var successHandler: (() -> Void)?
  var errorHandler: ((Error) -> Void)?
  
  func writeToPhotoAlbum(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
  }
  
  @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      errorHandler?(error)
    } else {
      successHandler?()
    }
  }
}
