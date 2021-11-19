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
      bindableTitleText.value    = item?.title
      bindablePriceText.value    = item?.price
      bindableLocationText.value = item?.user?.locationName
      
      downloadImage(from: item?.imageUrls![0])
    }
  }
  
  var bindableItemImage     = Bindable<UIImage>()
  var bindableTitleText     = Bindable<String>()
  var bindableLocationText  = Bindable<String>()
  var bindablePriceText     = Bindable<String>()

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
