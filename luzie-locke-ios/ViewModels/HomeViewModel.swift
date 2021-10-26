//
//  HomeViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import UIKit

class HomeViewModel {
  
  let coordinator:      HomeCoordinator
  let profileStorage:   AnyStorage<Profile>
  let openHttpClient:   OpenHTTPClient
  let backendApiClient: BackendAPIClient

//  var bindableProfileImage  = Bindable<UIImage>()
//  var bindableUserName      = Bindable<String>()
//  var bindableUserLocation  = Bindable<String>()

  init(coordinator:       HomeCoordinator,
       profileStorage:    AnyStorage<Profile>,
       openHttpClient:    OpenHTTPClient,
       backendApiClient:  BackendAPIClient) {
    self.coordinator      = coordinator
    self.profileStorage   = profileStorage
    self.openHttpClient   = openHttpClient
    self.backendApiClient = backendApiClient
  }
  
  func navigateToItemCreate() {
    coordinator.navigateToItemCreate()

  }
}
