//
//  ItemDisplayDetailViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.11.21.
//

import UIKit

class ItemDisplayDetailViewModel {
  
  private let openHttpClient: OpenHTTP
  
  let swipeImageViewModel: SwipeImageViewModel
  
  var bindableUserImage         = Bindable<UIImage>()
  var bindableUserNameText      = Bindable<String>()
  var bindableLocationText      = Bindable<String>()
  var bindableTitleText         = Bindable<String>()
  var bindableDescriptionText   = Bindable<String>()

  var item: Item? {
    didSet {
      if let item = item, let images = item.imageUrls {
        swipeImageViewModel.urls = images.compactMap{ $0 }
        
        bindableUserNameText.value    = item.user?.name
        bindableLocationText.value    = item.user?.locationName
        bindableTitleText.value       = item.title
        bindableDescriptionText.value = item.description
        
        
        bindableUserNameText.value    = item.user?.name
        bindableLocationText.value    = item.user?.locationName
        bindableTitleText.value       = item.title
        bindableDescriptionText.value = item.description
        
        if let url = item.user?.imageUrl {
          openHttpClient.downloadImage(from: url) { [weak self] result in
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
  }
  
  init(openHttpClient: OpenHTTP) {
    self.openHttpClient       = openHttpClient
    self.swipeImageViewModel  = SwipeImageViewModel(openHttpClient: openHttpClient)
  }
}
