//
//  SearchCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class ItemSearchCoordinator: Coordinator {

  var navigationController: UINavigationController
  var children = [Coordinator]()
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = ItemSearchViewController()
    vc.tabBarItem = UITabBarItem(title: nil,
                                 image: Images.search,
                                 selectedImage: Images.search)
    
    navigationController.pushViewController(vc, animated: true)
  }
}
