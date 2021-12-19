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
  let myProfileUseCase:         MyProfileUseCaseProtocol
  let openHttpClient:           OpenHTTP
  let backendApiClient:         BackendAPIClient
  
  let myProfileCellViewModel:   MyProfileCellViewModel

  init(coordinator:             SettingsCoordinator,
       auth:                    Auth,
       myProfileUseCase:        MyProfileUseCaseProtocol,
       openHttpClient:          OpenHTTP,
       backendApiClient:        BackendAPIClient) {
    self.coordinator            = coordinator
    self.auth                   = auth
    self.myProfileUseCase       = myProfileUseCase
    self.openHttpClient         = openHttpClient
    self.backendApiClient       = backendApiClient
    
    myProfileCellViewModel      =  MyProfileCellViewModel(openHttpClient: openHttpClient)
  }
  
  func load() {
    if let name = myProfileUseCase.getName(),
       let city = myProfileUseCase.getCity(),
       let imageUrl = myProfileUseCase.getImageUrl()
    {
      myProfileCellViewModel.model = MyProfileCellModel(name: name, city: city, imageUrl: imageUrl)
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
