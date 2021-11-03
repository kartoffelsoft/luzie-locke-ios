//
//  ItemDisplayBriefViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import Foundation

class ItemDisplayBriefViewModel {
  
  private let openHttpClient: OpenHTTP
  
  let swipeImageViewModel: SwipeImageViewModel
  
  var bindableTitleText         = Bindable<String>()
  var bindableLocationText      = Bindable<String>()
  
  var item: Item? {
    didSet {
      if let item = item, let images = item.images {
        swipeImageViewModel.urls = images.compactMap{ $0 }
        
        bindableTitleText.value = item.title
        bindableLocationText.value = item.user?.location?.name
      }
    }
  }
  
  init(openHttpClient: OpenHTTP) {
    self.openHttpClient = openHttpClient
    self.swipeImageViewModel = SwipeImageViewModel(openHttpClient: openHttpClient)
  }
}
