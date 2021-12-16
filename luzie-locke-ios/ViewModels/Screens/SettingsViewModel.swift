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
    coordinator.navigateToVerifyNeighborhood()
  }
  
  func logout() {
    auth.logout()
  }
}
