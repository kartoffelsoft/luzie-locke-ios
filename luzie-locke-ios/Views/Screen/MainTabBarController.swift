//
//  ViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  let auth:                   AuthService
  let storage:                StorageService
  let loginCoordinator:       Coordinator
  
  let homeCoordinator:        HomeCoordinator
  let searchCoordinator:      SearchCoordinator
  let chatsCoordinator:       ChatsCoordinator
  let settingsCoordinator:    SettingsCoordinator
  
  init(auth: AuthService, storage: StorageService, loginCoordinator: Coordinator) {
    self.auth                   = auth
    self.storage                = storage
    self.loginCoordinator       = loginCoordinator
    self.homeCoordinator        = HomeCoordinator(navigationController: UINavigationController(), profileStorage: storage.profile)
    self.searchCoordinator      = SearchCoordinator(navigationController: UINavigationController(), profileStorage: storage.profile)
    self.chatsCoordinator       = ChatsCoordinator(navigationController: UINavigationController(), profileStorage: storage.profile)
    self.settingsCoordinator    = SettingsCoordinator(navigationController: UINavigationController(), profileStorage: storage.profile)
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    homeCoordinator.start()
    searchCoordinator.start()
    chatsCoordinator.start()
    settingsCoordinator.start()
    
    view.backgroundColor    = .white
    tabBar.tintColor        = UIColor.label
    viewControllers         = [ homeCoordinator.navigationController,
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
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
