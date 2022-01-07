//
//  ItemDisplayDetailViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.11.21.
//

import UIKit

class ItemDisplayDetailViewModel {
  
  private let imageUseCase: ImageUseCaseProtocol
  
  let swipeImageViewModel: SwipeImageViewModel
  
  var bindableUserImage       = Bindable<UIImage>()
  var bindableUserNameText    = Bindable<String>()
  var bindableLocationText    = Bindable<String>()
  var bindableTitleText       = Bindable<String>()
  var bindableDescriptionText = Bindable<String>()

  var model: ItemDisplay? {
    didSet {
      if let model = model {
        swipeImageViewModel.urls = model.imageUrls.compactMap{ $0 }
        
        bindableUserNameText.value    = model.userName
        bindableLocationText.value    = model.location
        bindableTitleText.value       = model.title
        bindableDescriptionText.value = model.description
        
        imageUseCase.getImage(url: model.userImageUrl) { [weak self] result in
          switch result {
          case .success(let image):
            self?.bindableUserImage.value = image
          case .failure:
            ()
          }
        }
      }
    }
  }
  
  init(imageUseCase: ImageUseCaseProtocol) {
    self.imageUseCase         = imageUseCase
    self.swipeImageViewModel  = SwipeImageViewModel(imageUseCase: imageUseCase)
  }
}
