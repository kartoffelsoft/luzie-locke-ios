//
//  SearchCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class ItemSearchCoordinator: Coordinatable {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
  let factory: Factory
  var navigationController: UINavigationController
  var children = [Coordinatable]()
  
  init(factory: Factory,
       navigationController: UINavigationController) {
    self.factory              = factory
    self.navigationController = navigationController
  }
  
  func start() {
    let vm = factory.makeItemSearchViewModel(coordinator: self)
    let vc = ItemSearchViewController(viewModel: vm)
    vc.tabBarItem = UITabBarItem(title: nil,
                                 image: Images.search,
                                 selectedImage: Images.search)
    
    navigationController.pushViewController(vc, animated: true)
  }
  
  func navigateToItemDisplay(id: String) {
    let coordinator = factory.makeItemDisplayCoordinator(navigationController: navigationController,
                                                         id: id)
    children.append(coordinator)
    coordinator.start()
  }
}
