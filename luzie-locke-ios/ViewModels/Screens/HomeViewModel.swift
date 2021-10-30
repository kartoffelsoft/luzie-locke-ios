//
//  HomeViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import UIKit

class HomeViewModel {
  
  let coordinator:      HomeCoordinator
  let profileStorage:   AnyStorage<User>
  let openHttpClient:   OpenHTTP
  let itemApiClient:    ItemAPIClient

//  var bindableProfileImage  = Bindable<UIImage>()
//  var bindableUserName      = Bindable<String>()
//  var bindableUserLocation  = Bindable<String>()

  init(coordinator:       HomeCoordinator,
       profileStorage:    AnyStorage<User>,
       openHttpClient:    OpenHTTP,
       itemApiClient:     ItemAPIClient) {
    self.coordinator      = coordinator
    self.profileStorage   = profileStorage
    self.openHttpClient   = openHttpClient
    self.itemApiClient = itemApiClient
  }
  
  func navigateToItemCreate() {
    coordinator.navigateToItemCreate()

  }
}
