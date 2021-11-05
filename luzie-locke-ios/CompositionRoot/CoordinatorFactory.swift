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
  func makeChatCoordinator()      -> ChatsCoordinator
  func makeSettingsCoordinator()  -> SettingsCoordinator
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
    return SearchCoordinator(navigationController: UINavigationController(),
                             profileStorage: profileStorage)
  }
  
  func makeChatCoordinator() -> ChatsCoordinator {
    return ChatsCoordinator(navigationController: UINavigationController(),
                            profileStorage: profileStorage)
  }
  
  func makeSettingsCoordinator() -> SettingsCoordinator {
    return SettingsCoordinator(factory: self,
                               navigationController: UINavigationController())
  }
}
