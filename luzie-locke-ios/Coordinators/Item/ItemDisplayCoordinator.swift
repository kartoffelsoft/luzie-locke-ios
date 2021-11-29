//
//  ItemDisplayCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.11.21.
//

import UIKit

class ItemDisplayCoordinator: NSObject, Coordinator {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
  let factory:              Factory
  var navigationController: UINavigationController
  let id:                   String
  
  var children = [Coordinator]()
  
  init(factory: Factory, navigationController: UINavigationController, id: String) {
    self.factory              = factory
    self.navigationController = navigationController
    self.id                   = id
  }
  
  func start() {
    let vm = factory.makeItemDisplayViewModel(coordinator: self, id: id)
    let vc = factory.makeItemDisplayViewController(viewModel: vm, coordinator: self)
    navigationController.pushViewController(vc, animated: true)
  }

  func popViewController() {
    DispatchQueue.main.async {
      self.navigationController.popViewController(animated: true)
    }
  }
  
  func presentMore(_ viewController: UIViewController, item: Item) {
    let vm = factory.makeItemDisplayDetailViewModel(item: item)
    let vc = factory.makeItemDisplayDetailViewController(viewModel: vm)
    viewController.present(vc, animated: true, completion: nil)
  }
  
  func navigateToChat(remoteUserId: String = "vSYEtPvIXzND6BSYYBBXwiVaI1v1") {
    let viewController        = factory.makeChatViewController()
    viewController.viewModel  = factory.makeChatViewModel(remoteUserId: remoteUserId)
    navigationController.pushViewController(viewController, animated: true)
  }
}
