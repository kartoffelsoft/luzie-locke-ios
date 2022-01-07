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
  func makeMessagesViewModel(coordinator: MessagesCoordinator) -> MessagesViewModel
  func makeSettingsViewModel(coordinator: SettingsCoordinator) -> SettingsViewModel
  
  func makeSignUpViewModel(coordinator: LoginCoordinator) -> SignUpViewModel
  
  func makeItemSearchViewModel(coordinator: ItemSearchCoordinator) -> ItemSearchViewModel
  func makeItemCreateViewModel(coordinator: HomeCoordinator) -> ItemCreateViewModel
  func makeItemUpdateViewModel(coordinator: ItemDisplayCoordinator) -> ItemUpdateViewModel
  func makeItemDisplayViewModel(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewModel
  func makeItemDisplayDetailViewModel(model: ItemDisplay) -> ItemDisplayDetailViewModel
  
  func makeChatViewModel(remoteUserId: String, itemId: String) -> ChatViewModel
  func makeUserListingsViewModel(coordinator: SettingsCoordinator) -> UserListingsViewModel
  func makeUserPurchasesViewModel(coordinator: SettingsCoordinator) -> UserPurchasesViewModel
  func makeUserFavoritesViewModel(coordinator: SettingsCoordinator) -> UserFavoritesViewModel
  
  func makeNeighborhoodSettingViewModel(coordinator: SettingsCoordinator) -> NeighborhoodSettingViewModel
  func makeVerifyNeighborhoodViewModel(coordinator: PopCoordinatable) -> VerifyNeighborhoodViewModel
}

extension CompositionRoot: ViewModelFactory {
  
  func makeLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel {
    return LoginViewModel(coordinator: coordinator,
                          auth: auth,
                          myProfileUseCase: myProfileUseCase,
                          backendApiClient: backendApiClient)
  }
  
  func makeHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
    return HomeViewModel(coordinator: coordinator,
                         myProfileUseCase: myProfileUseCase,
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
                             myProfileUseCase: myProfileUseCase,
                             imageUseCase: imageUseCase,
                             backendApiClient: backendApiClient)
  }
  
  func makeSignUpViewModel(coordinator: LoginCoordinator) -> SignUpViewModel {
    return SignUpViewModel(coordinator: coordinator)
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
                                imageUseCase: imageUseCase,
                                itemRepository: itemRepository,
                                userFavoriteItemUseCase: userFavoriteItemUseCase,
                                id: id)
  }
  
  func makeItemDisplayDetailViewModel(model: ItemDisplay) -> ItemDisplayDetailViewModel {
    let viewModel = ItemDisplayDetailViewModel(imageUseCase: imageUseCase)
    viewModel.model = model
    return viewModel
  }
  
  func makeChatViewModel(remoteUserId: String, itemId: String) -> ChatViewModel {
    return ChatViewModel(remoteUserId: remoteUserId,
                         itemId: itemId,
                         imageUseCase: imageUseCase,
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
