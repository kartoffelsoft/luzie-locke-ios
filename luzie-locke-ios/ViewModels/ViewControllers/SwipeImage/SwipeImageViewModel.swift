//
//  SwipeImageViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class SwipeImageViewModel {
  
  var bindableControllers = Bindable<[UIViewController]>()
  
  private let openHttpClient: OpenHTTP
  
  var urls: [String]? {
    didSet {
      if let urls = urls {
        bindableControllers.value = urls.map({ url -> UIViewController in
          let viewModel           = ImageViewModel(openHttpClient: openHttpClient)
          let imageViewController = ImageViewController(viewModel: viewModel)
          viewModel.url = url
          return imageViewController
        })
      }
    }
  }
  
  init(openHttpClient: OpenHTTP) {
    self.openHttpClient = openHttpClient
  }
}
