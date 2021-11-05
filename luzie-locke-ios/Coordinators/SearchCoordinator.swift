//
//  SearchCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class SearchCoordinator: Coordinator {

  var navigationController: UINavigationController
  var children = [Coordinator]()

  var profileStorage: AnyStorage<User>
  
  init(navigationController: UINavigationController, profileStorage: AnyStorage<User>) {
    self.navigationController = navigationController
    self.profileStorage = profileStorage
  }
  
  func start() {
    let vc = SearchViewController(profileStorage: profileStorage)
    vc.tabBarItem = UITabBarItem(title: nil,
                                 image: Images.search,
                                 selectedImage: Images.search)
    
    navigationController.pushViewController(vc, animated: false)
  }
}
