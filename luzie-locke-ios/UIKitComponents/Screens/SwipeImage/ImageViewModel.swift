//
//  ImageViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ImageViewModel {
  
  private let imageUseCase: ImageUseCaseProtocol
  
  var bindableImage = Bindable<UIImage>()
  
  var url: String? {
    didSet {
      if let url = url {
        imageUseCase.getImage(url: url) { [weak self] result in
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
  
  init(imageUseCase: ImageUseCaseProtocol) {
    self.imageUseCase = imageUseCase
  }
}
