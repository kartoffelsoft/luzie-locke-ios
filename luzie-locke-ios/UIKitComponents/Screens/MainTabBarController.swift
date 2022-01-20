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
  
  let authUseCase:          AuthUseCaseProtocol
  
  let homeCoordinator:      Coordinatable
  let messagesCoordinator:  MessagesCoordinator
  let settingsCoordinator:  SettingsCoordinator
  
  init(factory: Factory, authUseCase: AuthUseCaseProtocol) {
    self.authUseCase              = authUseCase
    self.homeCoordinator          = factory.makeHomeCoordinator()
    self.messagesCoordinator      = factory.makeMessagesCoordinator()
    self.settingsCoordinator      = factory.makeSettingsCoordinator()
    
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabBar()
    
    homeCoordinator.start()
    messagesCoordinator.start()
    settingsCoordinator.start()
    
    view.backgroundColor = .white
    viewControllers      = [ homeCoordinator.navigationController,
                             messagesCoordinator.navigationController,
                             settingsCoordinator.navigationController ]
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.isNavigationBarHidden = true
    
    if !authUseCase.isAuthenticated() {
      route?.didRequireLogin(self)
    }
  }

  func configureTabBar() {
    tabBar.tintColor                = UIColor.custom.secondaryColor
    tabBar.unselectedItemTintColor  = UIColor.custom.primaryColorLight2
    tabBar.barTintColor             = UIColor.custom.primaryColor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
