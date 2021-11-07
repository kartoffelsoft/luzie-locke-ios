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
  func makeSettingsViewController(viewModel: SettingsViewModel) -> SettingsViewController
  
  func makeItemCreateViewController(viewModel: ItemCreateViewModel) -> ItemCreateViewController
  func makeItemDisplayViewController(viewModel: ItemDisplayViewModel, coordinator: ItemDisplayCoordinator) -> ItemDisplayViewController
  func makeItemDisplayDetailViewController(viewModel: ItemDisplayDetailViewModel) -> ItemDisplayDetailViewController
}

extension CompositionRoot: ViewControllerFactory {
  
  func makeMainTabBarController() -> MainTabBarController {
    return MainTabBarController(factory: self, auth: auth)
  }
  
  func makeLoginViewController(viewModel: LoginViewModel) -> LoginViewController {
    return LoginViewController(viewModel: viewModel)
  }
  
  func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController {
    let vc = HomeViewController(viewModel: viewModel)
    vc.tabBarItem = UITabBarItem(title: nil, image: Images.home, selectedImage: Images.home)
    return vc
  }
  
  func makeSettingsViewController(viewModel: SettingsViewModel) -> SettingsViewController {
    let vc = SettingsViewController(viewModel: viewModel)
    vc.tabBarItem = UITabBarItem(title: nil, image: Images.settings, selectedImage: Images.settings)
    return vc
  }
  
  func makeItemCreateViewController(viewModel: ItemCreateViewModel) -> ItemCreateViewController {
    return ItemCreateViewController(viewModel: viewModel)
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
}
