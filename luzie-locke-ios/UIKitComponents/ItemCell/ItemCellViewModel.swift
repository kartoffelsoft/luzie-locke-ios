//
//  ItemCellViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 26.10.21.
//

import UIKit

class ItemCellViewModel {

  var model: ItemListElement? {
    didSet {
      guard let model = model else { return }
      
      bindableTitleText.value    = model.title
      bindableLocationText.value = model.city
      bindableDateText.value     = DateUtility.string(from: model.modifiedAt)
      bindablePriceText.value    = model.price
      
      imageUseCase.getImage(url: model.imageUrl) { [weak self] result in
        switch result {
        case .success(let image):
          self?.bindableItemImage.value = image
        case .failure:
          ()
        }
      }
    }
  }
  
  var bindableItemImage     = Bindable<UIImage>()
  var bindableTitleText     = Bindable<String>()
  var bindableLocationText  = Bindable<String>()
  var bindablePriceText     = Bindable<String>()
  var bindableDateText      = Bindable<String>()

  let imageUseCase: ImageUseCaseProtocol

  init(imageUseCase: ImageUseCaseProtocol) {
    self.imageUseCase = imageUseCase
  }
}
