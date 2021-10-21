//
//  ChatCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class ChatsCoordinator: Coordinator {
  
  var children = [Coordinator]()
  var navigationController: UINavigationController
  
  var profileStorage: AnyStorage<Profile>
  
  init(navigationController: UINavigationController, profileStorage: AnyStorage<Profile>) {
    self.navigationController = navigationController
    self.profileStorage = profileStorage
  }
  
  func start() {
    let vc = ChatsViewController(profileStorage: profileStorage)
    vc.tabBarItem = UITabBarItem(title: "Chat",
                                 image: UIImage(systemName: "message.circle"),
                                 selectedImage: UIImage(systemName: "message.circle.fill"))
    
    navigationController.pushViewController(vc, animated: false)
  }
}
