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
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel
  
  func makeItemDisplayViewModel(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewModel
  func makeItemDisplayDetailViewModel(item: Item) -> ItemDisplayDetailViewModel
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

  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel {
    return SettingsViewModel(coordinator: coordinator,
                             auth: auth,
                             profileStorage: profileStorage,
                             openHttpClient: openHttpClient,
                             backendApiClient: backendApiClient)
  }
  
  func makeItemDisplayViewModel(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewModel {
    return ItemDisplayViewModel(coordinator: coordinator,
                                profileStorage: profileStorage,
                                openHttpClient: openHttpClient,
                                itemRepository: itemRepository,
                                id: id)
  }
  
  func makeItemDisplayDetailViewModel(item: Item) -> ItemDisplayDetailViewModel {
    let viewModel = ItemDisplayDetailViewModel(openHttpClient: openHttpClient)
    viewModel.item = item
    return viewModel
  }
}
