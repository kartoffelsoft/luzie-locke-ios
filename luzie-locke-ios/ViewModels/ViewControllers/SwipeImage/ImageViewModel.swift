//
//  ImageViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ImageViewModel {
  
  var bindableImage = Bindable<UIImage>()
  
  private let openHttpClient: OpenHTTP
  
  var url: String? {
    didSet {
      if let url = url {
        openHttpClient.downloadImage(from: url) { [weak self] result in
          switch result {
          case .success(let image):
            self?.bindableImage.value = image
          case .failure:
            ()
          }
        }
      }
    }
  }
  
  init(openHttpClient: OpenHTTP) {
    self.openHttpClient = openHttpClient
  }
}
