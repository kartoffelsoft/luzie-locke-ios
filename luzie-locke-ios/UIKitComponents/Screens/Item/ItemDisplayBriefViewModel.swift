//
//  ItemDisplayBriefViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemDisplayBriefViewModel {
  
  private let coordinator: ItemDisplayCoordinator
  private let openHttpClient: OpenHTTP
  
  let swipeImageViewModel: SwipeImageViewModel
  
  var bindableTitleText         = Bindable<String>()
  var bindableLocationText      = Bindable<String>()
  
  var item: Item? {
    didSet {
      if let item = item, let imageUrls = item.imageUrls {
        swipeImageViewModel.urls    = imageUrls.compactMap{ $0 }
        
        bindableTitleText.value     = item.title
        bindableLocationText.value  = item.user?.city
      }
    }
  }
  
  init(coordinator: ItemDisplayCoordinator, openHttpClient: OpenHTTP) {
    self.coordinator          = coordinator
    self.openHttpClient       = openHttpClient
    self.swipeImageViewModel  = SwipeImageViewModel(openHttpClient: openHttpClient)
  }
  
  func didTapMoreButton(_ viewController: UIViewController) {
    if let item = item {
      coordinator.presentMore(viewController, item: item)
    }
  }
}
