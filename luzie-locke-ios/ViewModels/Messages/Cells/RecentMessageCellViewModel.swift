//
//  RecentMessageCellViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import UIKit

class RecentMessageCellViewModel {

  var message: RecentMessage? {
    didSet {
      bindableNameText.value     = message?.name
      bindableMessageText.value  = message?.text
      bindableDateText.value     = DateUtility.string(from: message?.date)
      
      downloadImage(from: message?.profileImageUrl)
    }
  }
  
  var bindableImage        = Bindable<UIImage>()
  var bindableNameText     = Bindable<String>()
  var bindableMessageText  = Bindable<String>()
  var bindableDateText     = Bindable<String>()
  
  let openHttpClient: OpenHTTP

  init(openHttpClient: OpenHTTP) {
    self.openHttpClient = openHttpClient
  }
  
  private func downloadImage(from url: String?) {
    if let url = url {
      openHttpClient.downloadImage(from: url) { [weak self] result in
        switch result {
        case .success(let image):
          self?.bindableImage.value = image
        case .failure:
          ()
        }
      }
    }
  }
}
