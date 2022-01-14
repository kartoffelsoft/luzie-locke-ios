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
  
  func makeSignUpViewController(viewModel: SignUpViewModel) -> SignUpViewController
  
  func makeItemSearchViewController(viewModel: ItemSearchViewModel) -> ItemSearchViewController
  func makeItemComposeViewController(viewModel: ItemComposeViewModel) -> ItemComposeViewController
}

extension CompositionRoot: ViewControllerFactory {
  
  func makeMainTabBarController() -> MainTabBarController {
    return MainTabBarController(factory: self, authUseCase: authUseCase)
  }
  
  func makeLoginViewController(viewModel: LoginViewModel) -> LoginViewController {
    return LoginViewController(viewModel: viewModel)
  }
  
  func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController {
    let viewController = HomeViewController(viewModel: viewModel)
    viewController.tabBarItem = UITabBarItem(title: nil, image: Images.home, selectedImage: Images.home)
    return viewController
  }

  func makeSettingsViewController(viewModel: SettingsViewModel) -> SettingsViewController {
    let viewController = SettingsViewController(viewModel: viewModel)
    viewController.tabBarItem = UITabBarItem(title: nil, image: Images.settings, selectedImage: Images.settings)
    return viewController
  }
  
  func makeSignUpViewController(viewModel: SignUpViewModel) -> SignUpViewController {
    return SignUpViewController(viewModel: viewModel)
  }
  
  func makeItemSearchViewController(viewModel: ItemSearchViewModel) -> ItemSearchViewController {
    return ItemSearchViewController(viewModel: viewModel)
  }
  
  func makeItemComposeViewController(viewModel: ItemComposeViewModel) -> ItemComposeViewController {
    return ItemComposeViewController(viewModel: viewModel)
  }
}
