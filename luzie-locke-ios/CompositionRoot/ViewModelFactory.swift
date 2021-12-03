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
  
  func makeItemSearchViewModel(coordinator: ItemSearchCoordinator) -> ItemSearchViewModel
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel
  func makeItemUpdateViewModel(coordinator: ItemDisplayCoordinator) -> ItemUpdateViewModel
  func makeItemDisplayViewModel(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewModel
  func makeItemDisplayDetailViewModel(item: Item) -> ItemDisplayDetailViewModel
  
  func makeChatViewModel(remoteUserId: String) -> ChatViewModel
  func makeUserListingsViewModel(coordinator: SettingsCoordinator) -> UserListingsViewModel
  func makeUserPurchasesViewModel(coordinator: SettingsCoordinator) -> UserPurchasesViewModel
  func makeUserFavoritesViewModel(coordinator: SettingsCoordinator) -> UserFavoritesViewModel
}

extension CompositionRoot: ViewModelFactory {
  
  func makeLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel {
    return LoginViewModel(coordinator: coordinator,
                          auth: auth,
                          localProfileRepository: localProfileRepository,
                          backendApiClient: backendApiClient)
  }
  
  func makeHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
    return HomeViewModel(coordinator: coordinator,
                         openHttpClient: openHttpClient,
                         itemRepository: itemRepository)
  }

  func makeMessagesViewModel(coordinator: MessagesCoordinator) -> MessagesViewModel {
    return MessagesViewModel(coordinator: coordinator,
                             openHttpClient: openHttpClient,
                             localProfileRepository: localProfileRepository,
                             chatMessageRepository: ChatMessageRepository(),
                             recentMessageRepository: RecentMessageRepository())
  }
  
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel {
    return SettingsViewModel(coordinator: coordinator,
                             auth: auth,
                             localProfileRepository: localProfileRepository,
                             openHttpClient: openHttpClient,
                             backendApiClient: backendApiClient)
  }
  
  func makeItemSearchViewModel(coordinator: ItemSearchCoordinator) -> ItemSearchViewModel {
    return ItemSearchViewModel(coordinator: coordinator,
                               openHttpClient: openHttpClient,
                               itemRepository: itemRepository)
  }
  
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel {
    return ItemCreateViewModel(coordinator: coordinator,
                               itemRepository: itemRepository)
  }
  
  func makeItemUpdateViewModel(coordinator: ItemDisplayCoordinator) -> ItemUpdateViewModel {
    return ItemUpdateViewModel(coordinator: coordinator,
                               openHttpClient: openHttpClient,
                               itemRepository: itemRepository)
  }

  func makeItemDisplayViewModel(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewModel {
    return ItemDisplayViewModel(coordinator: coordinator,
                                localProfileRepository: localProfileRepository,
                                openHttpClient: openHttpClient,
                                itemRepository: itemRepository,
                                favoriteItemRepository: favoriteItemRepository,
                                id: id)
  }
  
  func makeItemDisplayDetailViewModel(item: Item) -> ItemDisplayDetailViewModel {
    let viewModel = ItemDisplayDetailViewModel(openHttpClient: openHttpClient)
    viewModel.item = item
    return viewModel
  }
  
  func makeChatViewModel(remoteUserId: String) -> ChatViewModel {
    return ChatViewModel(remoteUserId: remoteUserId,
                         userProfileRepository: userProfileRepository,
                         chatMessageRepository: ChatMessageRepository(),
                         recentMessageRepository: RecentMessageRepository())
  }
  
  func makeUserListingsViewModel(coordinator: SettingsCoordinator) -> UserListingsViewModel {
    return UserListingsViewModel(coordinator: coordinator,
                                 openHttpClient: openHttpClient,
                                 itemRepository: itemRepository)
  }
  
  func makeUserPurchasesViewModel(coordinator: SettingsCoordinator) -> UserPurchasesViewModel {
    return UserPurchasesViewModel(coordinator: coordinator,
                                  openHttpClient: openHttpClient,
                                  itemRepository: itemRepository)
  }
  
  func makeUserFavoritesViewModel(coordinator: SettingsCoordinator) -> UserFavoritesViewModel {
    return UserFavoritesViewModel(coordinator: coordinator,
                                  openHttpClient: openHttpClient,
                                  itemRepository: itemRepository)
  }
}
