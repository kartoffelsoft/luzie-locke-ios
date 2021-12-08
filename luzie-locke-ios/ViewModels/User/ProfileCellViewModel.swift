//
//  ProfileCellViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 26.10.21.
//

import UIKit

class ProfileCellViewModel {

  var profile: UserProfile? {
    didSet {
      bindableNameText.value     = profile?.name
      bindableLocationText.value = profile?.city
      
      downloadImage(from: profile?.imageUrl)
    }
  }
  
  var bindableProfileImage  = Bindable<UIImage>()
  var bindableNameText      = Bindable<String>()
  var bindableLocationText  = Bindable<String>()

  let openHttpClient: OpenHTTP

  init(openHttpClient: OpenHTTP) {
    self.openHttpClient = openHttpClient
  }
  
  private func downloadImage(from url: String?) {
    if let url = url {
      openHttpClient.downloadImage(from: url) { [weak self] result in
        switch result {
        case .success(let image):
          self?.bindableProfileImage.value = image
        case .failure:
          ()
        }
      }
    }
  }
}
