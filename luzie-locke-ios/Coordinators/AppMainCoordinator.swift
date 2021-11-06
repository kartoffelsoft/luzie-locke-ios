//
//  AppMainCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 05.11.21.
//

import UIKit

class AppMainCoordinator: Coordinator {

  typealias Factory = ViewControllerFactory & CoordinatorFactory
  let factory: Factory
  
  var navigationController: UINavigationController
  var children: [Coordinator] = []

  let window: UIWindow
  
  init(factory: Factory,
       window: UIWindow,
       navigationController: UINavigationController = UINavigationController()) {
    self.factory                = factory
    self.window                 = window
    self.navigationController   = navigationController
  }
  
  func start() {
    let viewController = factory.makeMainTabBarController()
    viewController.route = self
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
}

extension AppMainCoordinator: MainTabBarControllerRouteDelegate{
  
  func didRequireLogin(_ from: UIViewController) {
    let coordinator = factory.makeLoginCoordinator()
    coordinator.start()
    from.present(coordinator.navigationController, animated: true)
  }
}
