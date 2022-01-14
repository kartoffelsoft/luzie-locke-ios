//
//  ItemViewFactory.swift
//  luzie-locke-ios
//
//  Created by Harry on 14.01.22.
//

import UIKit

protocol ItemViewFactory {
  
  func makeItemDisplayView(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewController
  func makeItemDisplayDetailView(model: ItemDisplay) -> ItemDisplayDetailViewController
  func makeUserListingsView(coordinator: SettingsCoordinator) -> UserListingsViewController
  func makeUserPurchasesView(coordinator: SettingsCoordinator) -> UserPurchasesViewController
  func makeUserFavoritesView(coordinator: SettingsCoordinator) -> UserFavoritesViewController
}

extension CompositionRoot: ItemViewFactory {

  func makeItemDisplayView(coordinator: ItemDisplayCoordinator, id: String) -> ItemDisplayViewController {
    let vc = ItemDisplayViewController()
    vc.coordinator = coordinator
    vc.viewModel = ItemDisplayViewModel(coordinator: coordinator,
                                        myProfileUseCase: myProfileUseCase,
                                        imageUseCase: imageUseCase,
                                        itemRepository: itemRepository,
                                        userFavoriteItemUseCase: userFavoriteItemUseCase,
                                        id: id)
    return vc
  }
  
  func makeItemDisplayDetailView(model: ItemDisplay) -> ItemDisplayDetailViewController {
    let vm = ItemDisplayDetailViewModel(imageUseCase: imageUseCase)
    vm.model = model
    
    let vc = ItemDisplayDetailViewController()
    vc.viewModel = vm
    return vc
  }
  
  func makeUserListingsView(coordinator: SettingsCoordinator) -> UserListingsViewController {
    let vc = UserListingsViewController()
    vc.viewModel = UserListingsViewModel(coordinator: coordinator,
                                         imageUseCase: imageUseCase,
                                         userOpenItemUseCase: userOpenItemUseCase,
                                         userSoldItemUseCase: userSoldItemUseCase)
    return vc
  }
  
  func makeUserPurchasesView(coordinator: SettingsCoordinator) -> UserPurchasesViewController {
    let vc = UserPurchasesViewController()
    vc.viewModel = UserPurchasesViewModel(coordinator: coordinator,
                                          imageUseCase: imageUseCase,
                                          userBoughtItemUseCase: userBoughtItemUseCase)
    return vc
  }
  
  func makeUserFavoritesView(coordinator: SettingsCoordinator) -> UserFavoritesViewController {
    let vc = UserFavoritesViewController()
    vc.viewModel = UserFavoritesViewModel(coordinator: coordinator,
                                          userFavoriteItemUseCase: userFavoriteItemUseCase,
                                          imageUseCase: imageUseCase,
                                          itemRepository: itemRepository)
    return vc
  }
}
