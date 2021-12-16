//
//  ItemDisplayCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.11.21.
//

import UIKit

class ItemDisplayCoordinator: NSObject, Coordinatable {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
  let factory:              Factory
  var navigationController: UINavigationController
  let id:                   String
  
  var children = [Coordinatable]()
  
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

  func presentMore(_ viewController: UIViewController, item: Item) {
    let vm = factory.makeItemDisplayDetailViewModel(item: item)
    let vc = factory.makeItemDisplayDetailViewController(viewModel: vm)
    viewController.present(vc, animated: true, completion: nil)
  }
  
  func navigateToChat(remoteUserId: String, itemId: String) {
    let viewController        = factory.makeChatViewController()
    viewController.viewModel  = factory.makeChatViewModel(remoteUserId: remoteUserId, itemId: itemId)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func navigateToItemUpdate(item: Item) {
    let viewModel       = factory.makeItemUpdateViewModel(coordinator: self)
    let viewController  = factory.makeItemComposeViewController(viewModel: viewModel)
    viewModel.item      = item
    navigationController.pushViewController(viewController, animated: true)
  }
}

extension ItemDisplayCoordinator: PopCoordinatable {

  func popViewController() {
    DispatchQueue.main.async {
      self.navigationController.popViewController(animated: true)
    }
  }
  
  func popToRootViewController() {
    DispatchQueue.main.async {
      self.navigationController.popToRootViewController(animated: true)
    }
  }
}
