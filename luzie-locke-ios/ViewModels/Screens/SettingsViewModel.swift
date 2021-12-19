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
  let backendApiClient:         BackendAPIClient
  
  let myProfileCellViewModel:   MyProfileCellViewModel

  init(coordinator:             SettingsCoordinator,
       auth:                    Auth,
       myProfileUseCase:        MyProfileUseCaseProtocol,
       imageUseCase:            ImageUseCaseProtocol,
       backendApiClient:        BackendAPIClient) {
    self.coordinator            = coordinator
    self.auth                   = auth
    self.myProfileUseCase       = myProfileUseCase
    self.backendApiClient       = backendApiClient
    
    myProfileCellViewModel      =  MyProfileCellViewModel(imageUseCase: imageUseCase)
  }
  
  func load() {
    if let name = myProfileUseCase.getName(),
       let city = myProfileUseCase.getCity(),
       let imageUrl = myProfileUseCase.getImageUrl()
    {
      myProfileCellViewModel.model = UserProfileBrief(name: name, city: city, imageUrl: imageUrl)
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
