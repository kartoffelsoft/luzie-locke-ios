//
//  ItemDisplayBriefViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemDisplayBriefViewModel {
  
  private let coordinator: ItemDisplayCoordinatorProtocol
  
  let swipeImageViewModel: SwipeImageViewModel
  
  var bindableTitleText    = Bindable<String>()
  var bindableLocationText = Bindable<String>()
  
  var model: ItemDisplay? {
    didSet {
      if let model = model {
        swipeImageViewModel.urls    = model.imageUrls.compactMap{ $0 }
        
        bindableTitleText.value     = model.title
        bindableLocationText.value  = model.location
      }
    }
  }
  
  init(coordinator: ItemDisplayCoordinatorProtocol, imageUseCase: ImageUseCaseProtocol) {
    self.coordinator          = coordinator
    self.swipeImageViewModel  = SwipeImageViewModel(imageUseCase: imageUseCase)
  }
  
  func didTapMoreButton(_ viewController: UIViewController) {
    if let model = model {
      coordinator.presentMore(viewController, model: model)
    }
  }
}
