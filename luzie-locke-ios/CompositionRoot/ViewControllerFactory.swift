//
//  ViewControllerFactory.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.11.21.
//

import UIKit

protocol ViewControllerFactory {
  func makeMainTabBarController() -> MainTabBarController
}

extension CompositionRoot: ViewControllerFactory {
  
  func makeMainTabBarController() -> MainTabBarController {
    return MainTabBarController(auth: auth,
                                storage: storageService,
                                openHttpClient: openHttpClient,
                                backendApiClient: backendApiClient,
                                loginCoordinator: LoginCoordinator(navigationController: UINavigationController(),
                                                                   auth: auth,
                                                                   storage: storageService,
                                                                   backendApiClient: backendApiClient),
                                homeCoordinator: HomeCoordinator(navigationController: UINavigationController(),
                                                                 profileStorage: profileStorage,
                                                                 cloudStorage: cloudStorage,
                                                                 openHttpClient: openHttpClient,
                                                                 itemRepository: itemRepository)
    )
  }
}
