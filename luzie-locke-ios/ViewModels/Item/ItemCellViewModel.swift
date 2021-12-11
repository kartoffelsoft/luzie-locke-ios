//
//  ItemCellViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 26.10.21.
//

import UIKit

class ItemCellViewModel {

  var item: Item? {
    didSet {
      if let item = item {
        bindableTitleText.value    = item.title
        bindableLocationText.value = item.user?.city
        bindableDateText.value     = DateUtility.string(from: item.modifiedAt)
        
        let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: CustomUIFonts.detail])
        priceText.append(NSAttributedString(string: item.price ?? "0", attributes: [.font: CustomUIFonts.body]))
        bindablePriceText.value = priceText
        
        downloadImage(from: item.imageUrls![0])
      }
    }
  }
  
  var bindableItemImage     = Bindable<UIImage>()
  var bindableTitleText     = Bindable<String>()
  var bindableLocationText  = Bindable<String>()
  var bindablePriceText     = Bindable<NSAttributedString>()
  var bindableDateText      = Bindable<String>()

  let imageUseCase: ImageUseCaseProtocol

  init(imageUseCase: ImageUseCaseProtocol) {
    self.imageUseCase = imageUseCase
  }
  
  private func downloadImage(from url: String?) {
    if let url = url {
      imageUseCase.getImage(url: url) { [weak self] result in
        switch result {
        case .success(let image):
          self?.bindableItemImage.value = image
        case .failure:
          ()
        }
      }
    }
  }
}
