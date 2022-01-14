//
//  ItemDisplayCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.11.21.
//

import UIKit

protocol ItemDisplayCoordinatorProtocol {
  
  func presentMore(_ viewController: UIViewController, model: ItemDisplay)
  func navigateToCommunication(remoteUserId: String, itemId: String)
  func navigateToItemUpdate(itemId: String)
}

class ItemDisplayCoordinator: NSObject, Coordinatable {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory & CommunicationViewFactory
  
  let factory: Factory
  var navigationController: UINavigationController
  let itemId: String
  
  var children = [Coordinatable]()
  
  init(factory: Factory, navigationController: UINavigationController, itemId: String) {
    self.factory = factory
    self.navigationController = navigationController
    self.itemId = itemId
  }
  
  func start() {
    let vm = factory.makeItemDisplayViewModel(coordinator: self, id: itemId)
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
  
  func navigateToCommunication(remoteUserId: String, itemId: String) {
    let coordinator = factory.makeCommunicationCoordinator(navigationController: navigationController,
                                                           remoteUserId: remoteUserId,
                                                           itemId: itemId)
    children.append(coordinator)
    coordinator.start()
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
