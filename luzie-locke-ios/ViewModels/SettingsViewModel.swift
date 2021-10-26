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
  
  var bindableProfileImage  = Bindable<UIImage>()
  var bindableUserName      = Bindable<String>()
  var bindableUserLocation  = Bindable<String>()

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
  }
  
  func load() {
    if let profile = profileStorage.get() {
      bindableUserName.value      = profile.name
      bindableUserLocation.value  = profile.location.name
      
      openHttpClient.downloadImage(from: profile.pictureURI) { [weak self] result in
        switch result {
        case .success(let image):
          DispatchQueue.main.async { self?.bindableProfileImage.value = image }
        case .failure:
          ()
        }
      }
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
        }
      }
    }
  }
  
  func logout() {
    auth.logout()
  }
}
