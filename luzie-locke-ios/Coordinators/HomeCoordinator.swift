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
  
  let profileStorage:   AnyStorage<User>
  let openHttpClient:   OpenHTTP
  let backendApiClient: BackendAPIClient
  
  init(navigationController:  UINavigationController,
       profileStorage:        AnyStorage<User>,
       openHttpClient:        OpenHTTP,
       backendApiClient:      BackendAPIClient) {
    self.navigationController = navigationController
    self.profileStorage = profileStorage
    self.openHttpClient = openHttpClient
    self.backendApiClient = backendApiClient
    
    let vm = HomeViewModel(coordinator: self, profileStorage: profileStorage, openHttpClient: openHttpClient, backendApiClient: backendApiClient)
    let vc = HomeViewController(viewModel: vm)
    
    vc.tabBarItem = UITabBarItem(title: nil,
                                 image: Images.home,
                                 selectedImage: Images.home)
    
    navigationController.pushViewController(vc, animated: false)
  }
  
  func start() {
  }
  
  func navigateToItemCreate() {
    let vm = ItemCreateViewModel(coordinator: self,
                                 profileStorage: profileStorage,
                                 openHttpClient: openHttpClient,
                                 backendApiClient: backendApiClient)
    let vc = ItemCreateViewController(viewModel: vm)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
