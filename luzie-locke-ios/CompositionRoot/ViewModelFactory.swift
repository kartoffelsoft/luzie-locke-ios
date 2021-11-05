//
//  ViewModelFactory.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.11.21.
//

import Foundation

protocol ViewModelFactory {
  func makeLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel
  func makeHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel
  func makeItemDisplayViewModel(coordinator: HomeCoordinator, id: String) -> ItemDisplayViewModel
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel
}

extension CompositionRoot: ViewModelFactory {
  
  func makeLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel {
    LoginViewModel(coordinator: coordinator, auth: auth, storage: storageService, backendApiClient: backendApiClient)
  }
  
  func makeHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
    return HomeViewModel(coordinator: coordinator,
                         profileStorage: profileStorage,
                         openHttpClient: openHttpClient,
                         itemRepository: itemRepository)
  }
  
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel {
    return ItemCreateViewModel(coordinator: coordinator,
                               profileStorage: profileStorage,
                               cloudStorage: cloudStorage,
                               openHttpClient: openHttpClient,
                               itemRepository: itemRepository)
  }
  
  func makeItemDisplayViewModel(coordinator: HomeCoordinator, id: String) -> ItemDisplayViewModel {
    return ItemDisplayViewModel(coordinator: coordinator,
                                profileStorage: profileStorage,
                                openHttpClient: openHttpClient,
                                itemRepository: itemRepository,
                                id: id)
  }
  
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel {
    return SettingsViewModel(coordinator: coordinator,
                             auth: auth,
                             profileStorage: profileStorage,
                             openHttpClient: openHttpClient,
                             backendApiClient: backendApiClient)
  }
}
