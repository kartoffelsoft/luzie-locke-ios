//
//  ViewModelFactory.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.11.21.
//

import Foundation
import MapKit

protocol ViewModelFactory {
  
  func makeLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel
  func makeHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel

  func makeItemSearchViewModel(coordinator: ItemSearchCoordinator) -> ItemSearchViewModel
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel
  func makeItemUpdateViewModel(coordinator: ItemDisplayCoordinator) -> ItemUpdateViewModel
  
  func makeNeighborhoodSettingViewModel(coordinator: SettingsCoordinator) -> NeighborhoodSettingViewModel
  func makeVerifyNeighborhoodViewModel(coordinator: PopCoordinatable) -> VerifyNeighborhoodViewModel
}

extension CompositionRoot: ViewModelFactory {
  
  func makeLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel {
    return LoginViewModel(coordinator: coordinator,
                          authUseCase: authUseCase,
                          myProfileUseCase: myProfileUseCase,
                          backendApiClient: backendApiClient)
  }
  
  func makeHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
    return HomeViewModel(coordinator: coordinator,
                         myProfileUseCase: myProfileUseCase,
                         imageUseCase: imageUseCase,
                         itemRepository: itemRepository)
  }
  
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel {
    return SettingsViewModel(coordinator: coordinator,
                             authUseCase: authUseCase,
                             myProfileUseCase: myProfileUseCase,
                             imageUseCase: imageUseCase)
  }
  
  func makeItemSearchViewModel(coordinator: ItemSearchCoordinator) -> ItemSearchViewModel {
    return ItemSearchViewModel(coordinator: coordinator,
                               imageUseCase: imageUseCase,
                               itemRepository: itemRepository)
  }
  
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel {
    return ItemCreateViewModel(coordinator: coordinator,
                               itemRepository: itemRepository)
  }
  
  func makeItemUpdateViewModel(coordinator: ItemDisplayCoordinator) -> ItemUpdateViewModel {
    return ItemUpdateViewModel(coordinator: coordinator,
                               imageUseCase: imageUseCase,
                               itemRepository: itemRepository)
  }
  
  func makeNeighborhoodSettingViewModel(coordinator: SettingsCoordinator) -> NeighborhoodSettingViewModel {
    return NeighborhoodSettingViewModel(coordinator: coordinator,
                                        settingsUseCase: settingsUseCase)
  }
  
  func makeVerifyNeighborhoodViewModel(coordinator: PopCoordinatable) -> VerifyNeighborhoodViewModel {
    return VerifyNeighborhoodViewModel(locationManager: CLLocationManager(),
                                       coordinator: coordinator,
                                       settingsUseCase: settingsUseCase)
  }
}
