//
//  CoordinatorFactory.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.11.21.
//

import UIKit

protocol CoordinatorFactory {
  func makeLoginCoordinator()     -> LoginCoordinator
  func makeHomeCoordinator()      -> HomeCoordinator
  func makeSearchCoordinator()    -> SearchCoordinator
  func makeMessagesCoordinator()  -> MessagesCoordinator
  func makeSettingsCoordinator()  -> SettingsCoordinator
  
  func makeItemDisplayCoordinator(navigationController: UINavigationController, id: String) -> ItemDisplayCoordinator
}

extension CompositionRoot: CoordinatorFactory {
  
  func makeLoginCoordinator() -> LoginCoordinator {
    return LoginCoordinator(factory: self,
                            navigationController: UINavigationController())
  }
  
  func makeHomeCoordinator() -> HomeCoordinator {
    return HomeCoordinator(factory: self,
                           navigationController: UINavigationController())
  }
  
  func makeSearchCoordinator() -> SearchCoordinator {
    return SearchCoordinator(navigationController: UINavigationController())
  }
  
  func makeMessagesCoordinator() -> MessagesCoordinator {
    return MessagesCoordinator(factory: self,
                               navigationController: UINavigationController())
  }
  
  func makeSettingsCoordinator() -> SettingsCoordinator {
    return SettingsCoordinator(factory: self,
                               navigationController: UINavigationController())
  }
  
  func makeItemDisplayCoordinator(navigationController: UINavigationController, id: String)  -> ItemDisplayCoordinator {
    return ItemDisplayCoordinator(factory: self,
                                  navigationController: navigationController,
                                  id: id)
  }
}
