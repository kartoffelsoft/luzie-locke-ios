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
  let openHttpClient:         OpenHTTPClient
  let backendApiClient:       BackendAPIClient
  let loginCoordinator:       Coordinator
  
  let homeCoordinator:        HomeCoordinator
  let searchCoordinator:      SearchCoordinator
  let chatsCoordinator:       ChatsCoordinator
  let settingsCoordinator:    SettingsCoordinator
  
  init(auth: AuthService,
       storage: StorageService,
       openHttpClient: OpenHTTPClient,
       backendApiClient: BackendAPIClient,
       loginCoordinator: Coordinator) {
    self.auth                   = auth
    self.storage                = storage
    self.openHttpClient         = openHttpClient
    self.backendApiClient       = backendApiClient
    self.loginCoordinator       = loginCoordinator
    self.homeCoordinator        = HomeCoordinator(
                                    navigationController: UINavigationController(),
                                    profileStorage: storage.profile,
                                    openHttpClient: openHttpClient,
                                    backendApiClient: backendApiClient)
    self.searchCoordinator      = SearchCoordinator(navigationController: UINavigationController(), profileStorage: storage.profile)
    self.chatsCoordinator       = ChatsCoordinator(navigationController: UINavigationController(), profileStorage: storage.profile)
    self.settingsCoordinator    = SettingsCoordinator(
                                    navigationController: UINavigationController(),
                                    auth: auth,
                                    profileStorage: storage.profile,
                                    openHttpClient: openHttpClient,
                                    backendApiClient: backendApiClient)
    
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    homeCoordinator.start()
    searchCoordinator.start()
    chatsCoordinator.start()
    settingsCoordinator.start()
    
    view.backgroundColor            = .white
    tabBar.tintColor                = UIColor(named: "PrimaryColor")
    tabBar.unselectedItemTintColor  = .systemGray
    viewControllers                 = [ homeCoordinator.navigationController,
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
