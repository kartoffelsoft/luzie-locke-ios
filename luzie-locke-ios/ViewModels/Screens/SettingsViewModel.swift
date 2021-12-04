//
//  SettingsViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.10.21.
//

import UIKit

class SettingsViewModel {
  
  let coordinator:              SettingsCoordinator
  let auth:                     Auth
  let localProfileRepository:   LocalProfileRepository
  let openHttpClient:           OpenHTTP
  let backendApiClient:         BackendAPIClient
  
  let profileCellViewModel:     ProfileCellViewModel

  init(coordinator:             SettingsCoordinator,
       auth:                    Auth,
       localProfileRepository:  LocalProfileRepository,
       openHttpClient:          OpenHTTP,
       backendApiClient:        BackendAPIClient) {
    self.coordinator            = coordinator
    self.auth                   = auth
    self.localProfileRepository = localProfileRepository
    self.openHttpClient         = openHttpClient
    self.backendApiClient       = backendApiClient
    
    profileCellViewModel    =  ProfileCellViewModel(openHttpClient: openHttpClient)
  }
  
  func load() {
    if let profile = localProfileRepository.read() {
      profileCellViewModel.profile = profile
    }
  }
  
  func didTapListings() {
    coordinator.navigateToUserListings()
  }
  
  func didTapPurchases() {
    coordinator.navigateToUserPurchases()
  }
  
  func didTapFavorites() {
    coordinator.navigateToUserFavorites()
  }
  
  func didTapNeighborhoodSetting() {
    coordinator.navigateToNeighborhooodSetting()
  }
  
  func didTapVerifyNeighborhood() {
    coordinator.navigateToVerifyNeighborhood { [weak self] city, lat, lng in
      guard let self = self else { return }
      self.coordinator.popViewController()
      
      if let city = city, let lat = lat, let lng = lng {
        self.backendApiClient.userApi.updateLocation(city: city,
                                                     lat: lat,
                                                     lng: lng) { result in
          switch result {
          case .success(let profile):
            self.localProfileRepository.update(profile)
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
