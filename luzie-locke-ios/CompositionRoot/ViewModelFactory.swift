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
  func makeMessagesViewModel(coordinator: MessagesCoordinator) -> MessagesViewModel
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel
  
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel
  func makeItemDisplayViewModel(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewModel
  func makeItemDisplayDetailViewModel(item: Item) -> ItemDisplayDetailViewModel
  
  func makeChatViewModel() -> ChatViewModel
}

extension CompositionRoot: ViewModelFactory {
  
  func makeLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel {
    return LoginViewModel(coordinator: coordinator,
                          auth: auth,
                          profileRepository: profileRepository,
                          backendApiClient: backendApiClient)
  }
  
  func makeHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
    return HomeViewModel(coordinator: coordinator,
                         profileRepository: profileRepository,
                         openHttpClient: openHttpClient,
                         itemRepository: itemRepository)
  }

  func makeMessagesViewModel(coordinator: MessagesCoordinator) -> MessagesViewModel {
    return MessagesViewModel(coordinator: coordinator,
                             profileRepository: profileRepository)
  }
  
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel {
    return SettingsViewModel(coordinator: coordinator,
                             auth: auth,
                             profileRepository: profileRepository,
                             openHttpClient: openHttpClient,
                             backendApiClient: backendApiClient)
  }
  
  
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel {
    return ItemCreateViewModel(coordinator: coordinator,
                               profileRepository: profileRepository,
                               cloudStorage: cloudStorage,
                               openHttpClient: openHttpClient,
                               itemRepository: itemRepository)
  }
  
  func makeItemDisplayViewModel(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewModel {
    return ItemDisplayViewModel(coordinator: coordinator,
                                profileRepository: profileRepository,
                                openHttpClient: openHttpClient,
                                itemRepository: itemRepository,
                                id: id)
  }
  
  func makeItemDisplayDetailViewModel(item: Item) -> ItemDisplayDetailViewModel {
    let viewModel = ItemDisplayDetailViewModel(openHttpClient: openHttpClient)
    viewModel.item = item
    return viewModel
  }
  
  
  func makeChatViewModel() -> ChatViewModel {
    return ChatViewModel()
  }
}
