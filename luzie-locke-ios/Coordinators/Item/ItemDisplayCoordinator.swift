//
//  ItemDisplayCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.11.21.
//

import UIKit

protocol ItemDisplayCoordinatorProtocol {
  func presentMore(_ viewController: UIViewController, model: ItemDisplay)
  func navigateToChat(remoteUserId: String, itemId: String)
  func navigateToItemUpdate(itemId: String)
}

class ItemDisplayCoordinator: NSObject, Coordinatable {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory & CommunicationViewFactory
  
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
}

extension ItemDisplayCoordinator: ItemDisplayCoordinatorProtocol {
  
  func presentMore(_ viewController: UIViewController, model: ItemDisplay) {
    let vm = factory.makeItemDisplayDetailViewModel(model: model)
    let vc = factory.makeItemDisplayDetailViewController(viewModel: vm)
    viewController.present(vc, animated: true, completion: nil)
  }
  
  func navigateToChat(remoteUserId: String, itemId: String) {
    navigationController.pushViewController(
      factory.makeMessageView(remoteUserId: remoteUserId, itemId: itemId),
      animated: true)
  }
  
  func navigateToItemUpdate(itemId: String) {
    let viewModel       = factory.makeItemUpdateViewModel(coordinator: self)
    let viewController  = factory.makeItemComposeViewController(viewModel: viewModel)
    viewModel.itemId      = itemId
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
