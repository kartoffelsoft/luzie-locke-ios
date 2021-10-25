//
//  HomeCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class HomeCoordinator: Coordinator {
  
  var children = [Coordinator]()
  var navigationController: UINavigationController
  
  let profileStorage:   AnyStorage<Profile>
  let openHttpClient:   OpenHTTPClient
  let backendApiClient: BackendAPIClient
  
  init(navigationController:  UINavigationController,
       profileStorage:        AnyStorage<Profile>,
       openHttpClient:        OpenHTTPClient,
       backendApiClient:      BackendAPIClient) {
    self.navigationController = navigationController
    self.profileStorage = profileStorage
    self.openHttpClient = openHttpClient
    self.backendApiClient = backendApiClient
  }
  
  func start() {
    let vc = HomeViewController(profileStorage: profileStorage)
    vc.tabBarItem   = UITabBarItem(title: "Home",
                                   image: Images.home,
                                   selectedImage: Images.home)
    
    navigationController.pushViewController(vc, animated: false)
  }
}
