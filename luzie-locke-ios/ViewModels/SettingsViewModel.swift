//
//  SettingsViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.10.21.
//

import UIKit

class SettingsViewModel {
  
  let coordinator:      SettingsCoordinator
  let auth:             Auth
  let profileStorage:   AnyStorage<Profile>
  let openHttpClient:   OpenHTTP
  let backendApiClient: BackendAPIClient
  
  let profileCellViewModel: ProfileCellViewModel

  init(coordinator:       SettingsCoordinator,
       auth:              Auth,
       profileStorage:    AnyStorage<Profile>,
       openHttpClient:    OpenHTTP,
       backendApiClient:  BackendAPIClient) {
    self.coordinator      = coordinator
    self.auth             = auth
    self.profileStorage   = profileStorage
    self.openHttpClient   = openHttpClient
    self.backendApiClient = backendApiClient
    
    profileCellViewModel =  ProfileCellViewModel(openHttpClient: openHttpClient)
  }
  
  func load() {
    if let profile = profileStorage.get() {
      profileCellViewModel.profile = profile
    }
  }
  
  func navigateToMap() {
    coordinator.navigateToMap { [weak self] name, lat, lng in
      guard let self = self else { return }
      self.coordinator.popViewController()
      
      if let name = name, let lat = lat, let lng = lng {
        self.backendApiClient.userApi.updateLocation(name: name,
                                                  lat: lat,
                                                  lng: lng) { result in
          switch result {
          case .success(let profile):
            self.profileStorage.set(profile)          
          case .failure:
            ()
          case .none:
            ()
          }
        }
      }
    }
  }
  
  func logout() {
    auth.logout()
  }
}
