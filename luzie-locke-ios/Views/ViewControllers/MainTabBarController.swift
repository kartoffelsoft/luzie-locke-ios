//
//  ViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory
  
  let auth:                   Auth
  let loginCoordinator:       Coordinator
  
  let homeCoordinator:        Coordinator
  let searchCoordinator:      SearchCoordinator
  let chatsCoordinator:       ChatsCoordinator
  let settingsCoordinator:    SettingsCoordinator
  
  init(factory: Factory, auth: Auth) {
    self.auth                 = auth
    self.loginCoordinator     = factory.makeLoginCoordinator()
    self.homeCoordinator      = factory.makeHomeCoordinator()
    self.searchCoordinator    = factory.makeSearchCoordinator()
    self.chatsCoordinator     = factory.makeChatCoordinator()
    self.settingsCoordinator  = factory.makeSettingsCoordinator()
    
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabBar()
    
    homeCoordinator.start()
    searchCoordinator.start()
    chatsCoordinator.start()
    settingsCoordinator.start()
    
    view.backgroundColor = .white
    viewControllers      = [ homeCoordinator.navigationController,
                             searchCoordinator.navigationController,
                             chatsCoordinator.navigationController,
                             settingsCoordinator.navigationController ]
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.isNavigationBarHidden = true
    
    if !auth.isAuthenticated() {
      self.loginCoordinator.start()
      self.present(self.loginCoordinator.navigationController, animated: true)
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
