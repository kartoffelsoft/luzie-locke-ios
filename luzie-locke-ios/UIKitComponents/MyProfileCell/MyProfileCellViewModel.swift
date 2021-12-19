//
//  MyProfileCellViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 26.10.21.
//

import UIKit

class MyProfileCellViewModel {

  var model: UserProfileBrief? {
    didSet {
      guard let model = model else { return }
      
      bindableNameText.value     = model.name
      bindableLocationText.value = model.city
      
      imageUseCase.getImage(url: model.imageUrl){ [weak self] result in
        switch result {
        case .success(let image):
          self?.bindableProfileImage.value = image
        case .failure:
          ()
        }
      }
    }
  }
  
  var bindableProfileImage  = Bindable<UIImage>()
  var bindableNameText      = Bindable<String>()
  var bindableLocationText  = Bindable<String>()

  private let imageUseCase: ImageUseCaseProtocol

  init(imageUseCase: ImageUseCaseProtocol) {
    self.imageUseCase = imageUseCase
  }
}
