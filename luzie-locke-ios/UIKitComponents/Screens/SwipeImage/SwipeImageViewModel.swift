//
//  SwipeImageViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class SwipeImageViewModel {
  
  var bindableControllers = Bindable<[UIViewController]>()
  
  private let imageUseCase: ImageUseCaseProtocol
  
  var urls: [String]? {
    didSet {
      if let urls = urls {
        bindableControllers.value = urls.map({ url -> UIViewController in
          let viewModel           = ImageViewModel(imageUseCase: imageUseCase)
          let imageViewController = ImageViewController(viewModel: viewModel)
          viewModel.url = url
          return imageViewController
        })
      }
    }
  }
  
  init(imageUseCase: ImageUseCaseProtocol) {
    self.imageUseCase = imageUseCase
  }
}
