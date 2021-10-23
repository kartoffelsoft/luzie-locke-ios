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
  
  var profileStorage: AnyStorage<Profile>
  
  init(navigationController: UINavigationController, profileStorage: AnyStorage<Profile>) {
    self.navigationController = navigationController
    self.profileStorage = profileStorage
  }
  
  func start() {
    let vc = HomeViewController(profileStorage: profileStorage)
    vc.tabBarItem   = UITabBarItem(title: "Home",
                                   image: Images.home,
                                   selectedImage: Images.home)
    
    navigationController.pushViewController(vc, animated: false)
  }
}
