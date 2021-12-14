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
  
  func makeChatViewModel(remoteUserId: String, itemId: String) -> ChatViewModel
  func makeUserListingsViewModel(coordinator: SettingsCoordinator) -> UserListingsViewModel
  func makeUserPurchasesViewModel(coordinator: SettingsCoordinator) -> UserPurchasesViewModel
  func makeUserFavoritesViewModel(coordinator: SettingsCoordinator) -> UserFavoritesViewModel
  
  func makeNeighbourhoodSettingViewModel(coordinator: SettingsCoordinator) -> NeighbourhoodSettingViewModel
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
                         imageUseCase: imageUseCase,
                         itemRepository: itemRepository)
  }

  func makeMessagesViewModel(coordinator: MessagesCoordinator) -> MessagesViewModel {
    return MessagesViewModel(coordinator: coordinator,
                             imageUseCase: imageUseCase,
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
                               imageUseCase: imageUseCase,
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
                                myProfileUseCase: myProfileUseCase,
                                openHttpClient: openHttpClient,
                                itemRepository: itemRepository,
                                userFavoriteItemUseCase: userFavoriteItemUseCase,
                                id: id)
  }
  
  func makeItemDisplayDetailViewModel(item: Item) -> ItemDisplayDetailViewModel {
    let viewModel = ItemDisplayDetailViewModel(openHttpClient: openHttpClient)
    viewModel.item = item
    return viewModel
  }
  
  func makeChatViewModel(remoteUserId: String, itemId: String) -> ChatViewModel {
    return ChatViewModel(remoteUserId: remoteUserId,
                         itemId: itemId,
                         itemControlUseCase: itemControlUseCase,
                         userProfileRepository: userProfileRepository,
                         chatMessageRepository: ChatMessageRepository(),
                         recentMessageRepository: RecentMessageRepository())
  }
  
  func makeUserListingsViewModel(coordinator: SettingsCoordinator) -> UserListingsViewModel {
    return UserListingsViewModel(coordinator: coordinator,
                                 imageUseCase: imageUseCase,
                                 userOpenItemUseCase: userOpenItemUseCase,
                                 userSoldItemUseCase: userSoldItemUseCase)
  }
  
  func makeUserPurchasesViewModel(coordinator: SettingsCoordinator) -> UserPurchasesViewModel {
    return UserPurchasesViewModel(coordinator: coordinator,
                                  imageUseCase: imageUseCase,
                                  userBoughtItemUseCase: userBoughtItemUseCase)
  }
  
  func makeUserFavoritesViewModel(coordinator: SettingsCoordinator) -> UserFavoritesViewModel {
    return UserFavoritesViewModel(coordinator: coordinator,
                                  userFavoriteItemUseCase: userFavoriteItemUseCase,
                                  imageUseCase: imageUseCase,
                                  itemRepository: itemRepository)
  }
  
  func makeNeighbourhoodSettingViewModel(coordinator: SettingsCoordinator) -> NeighbourhoodSettingViewModel {
    return NeighbourhoodSettingViewModel(coordinator: coordinator,
                                         settingsRepository: settingsRepository)
  }
}
