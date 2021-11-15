//
//  ViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

protocol MainTabBarControllerRouteDelegate: AnyObject {
  func didRequireLogin(_ from: UIViewController)
}

class MainTabBarController: UITabBarController {
  
  weak var route: MainTabBarControllerRouteDelegate?
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory
  
  let auth:                 Auth
  
  let homeCoordinator:      Coordinator
  let messagesCoordinator:  MessagesCoordinator
  let settingsCoordinator:  SettingsCoordinator
  
  init(factory: Factory, auth: Auth) {
    self.auth                     = auth
    self.homeCoordinator          = factory.makeHomeCoordinator()
//    self.searchCoordinator        = factory.makeSearchCoordinator()
    self.messagesCoordinator      = factory.makeMessagesCoordinator()
    self.settingsCoordinator      = factory.makeSettingsCoordinator()
    
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabBar()
    
    homeCoordinator.start()
//    searchCoordinator.start()
    messagesCoordinator.start()
    settingsCoordinator.start()
    
    view.backgroundColor = .white
    viewControllers      = [ homeCoordinator.navigationController,
//                             searchCoordinator.navigationController,
                             messagesCoordinator.navigationController,
                             settingsCoordinator.navigationController ]
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.isNavigationBarHidden = true
    
    if !auth.isAuthenticated() {
      route?.didRequireLogin(self)
    }
  }
  
  func configureTabBar() {
    tabBar.tintColor                = Colors.secondaryColor
    tabBar.unselectedItemTintColor  = Colors.primaryColorLight2
    tabBar.barTintColor             = Colors.primaryColor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
