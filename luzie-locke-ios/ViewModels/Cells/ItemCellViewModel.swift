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
        
        let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: Fonts.detail])
        priceText.append(NSAttributedString(string: item.price ?? "0", attributes: [.font: Fonts.body]))
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

  let openHttpClient: OpenHTTP

  init(openHttpClient: OpenHTTP) {
    self.openHttpClient = openHttpClient
  }
  
  private func downloadImage(from url: String?) {
    if let url = url {
      openHttpClient.downloadImage(from: url) { [weak self] result in
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
