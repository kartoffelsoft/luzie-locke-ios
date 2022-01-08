//
//  SettingsViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.10.21.
//

import UIKit

class SettingsViewModel {
  
  let coordinator:              SettingsCoordinatorProtocol
  let authUseCase:              AuthUseCaseProtocol
  let myProfileUseCase:         MyProfileUseCaseProtocol
  
  let myProfileCellViewModel:   MyProfileCellViewModel

  init(coordinator:             SettingsCoordinatorProtocol,
       authUseCase:             AuthUseCaseProtocol,
       myProfileUseCase:        MyProfileUseCaseProtocol,
       imageUseCase:            ImageUseCaseProtocol) {
    self.coordinator            = coordinator
    self.authUseCase            = authUseCase
    self.myProfileUseCase       = myProfileUseCase
    
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
    authUseCase.logout()
  }
}
