//
//  ViewControllerFactory.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.11.21.
//

import UIKit

protocol ViewControllerFactory {
  func makeMainTabBarController() -> MainTabBarController
  func makeLoginViewController(viewModel: LoginViewModel) -> LoginViewController
  func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController
  func makeMessagesViewController() -> MessagesViewController
  func makeSettingsViewController(viewModel: SettingsViewModel) -> SettingsViewController
  
  func makeItemSearchViewController(viewModel: ItemSearchViewModel) -> ItemSearchViewController
  func makeItemComposeViewController(viewModel: ItemComposeViewModel) -> ItemComposeViewController
  func makeItemDisplayViewController(viewModel: ItemDisplayViewModel, coordinator: ItemDisplayCoordinator) -> ItemDisplayViewController
  func makeItemDisplayDetailViewController(viewModel: ItemDisplayDetailViewModel) -> ItemDisplayDetailViewController
  
  func makeChatViewController() -> ChatViewController
  func makeUserListingsViewController(viewModel: UserListingsViewModel) -> UserListingsViewController
  func makeUserPurchasesViewController(viewModel: UserPurchasesViewModel) -> UserPurchasesViewController
  func makeUserFavoritesViewController(viewModel: UserFavoritesViewModel) -> UserFavoritesViewController
}

extension CompositionRoot: ViewControllerFactory {
  
  func makeMainTabBarController() -> MainTabBarController {
    return MainTabBarController(factory: self, auth: auth)
  }
  
  func makeLoginViewController(viewModel: LoginViewModel) -> LoginViewController {
    return LoginViewController(viewModel: viewModel)
  }
  
  func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController {
    let viewController = HomeViewController(viewModel: viewModel)
    viewController.tabBarItem = UITabBarItem(title: nil, image: Images.home, selectedImage: Images.home)
    return viewController
  }
  
  func makeMessagesViewController() -> MessagesViewController {
    let viewController = MessagesViewController()
    viewController.tabBarItem = UITabBarItem(title: nil, image: Images.chats, selectedImage: Images.chats)
    return viewController
  }

  func makeSettingsViewController(viewModel: SettingsViewModel) -> SettingsViewController {
    let viewController = SettingsViewController(viewModel: viewModel)
    viewController.tabBarItem = UITabBarItem(title: nil, image: Images.settings, selectedImage: Images.settings)
    return viewController
  }
  
  func makeItemSearchViewController(viewModel: ItemSearchViewModel) -> ItemSearchViewController {
    return ItemSearchViewController(viewModel: viewModel)
  }
  
  func makeItemComposeViewController(viewModel: ItemComposeViewModel) -> ItemComposeViewController {
    return ItemComposeViewController(viewModel: viewModel)
  }
  
  func makeItemDisplayViewController(viewModel: ItemDisplayViewModel, coordinator: ItemDisplayCoordinator) -> ItemDisplayViewController {
    let viewController = ItemDisplayViewController(viewModel: viewModel)
    viewController.coordinator = coordinator
    return viewController
  }
  
  func makeItemDisplayDetailViewController(viewModel: ItemDisplayDetailViewModel) -> ItemDisplayDetailViewController {
    let viewController = ItemDisplayDetailViewController(viewModel: viewModel)
    return viewController
  }
  
  
  func makeChatViewController() -> ChatViewController {
    return ChatViewController()
  }
  
  func makeUserListingsViewController(viewModel: UserListingsViewModel) -> UserListingsViewController {
    return UserListingsViewController(viewModel: viewModel)
  }
  
  func makeUserPurchasesViewController(viewModel: UserPurchasesViewModel) -> UserPurchasesViewController {
    return UserPurchasesViewController(viewModel: viewModel)
  }
  
  func makeUserFavoritesViewController(viewModel: UserFavoritesViewModel) -> UserFavoritesViewController {
    return UserFavoritesViewController(viewModel: viewModel)
  }
}
