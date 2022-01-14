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
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory & ItemViewFactory & CommunicationViewFactory
  
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
    navigationController.pushViewController(
      factory.makeItemDisplayView(coordinator: self, id: itemId),
      animated: true)
  }
}

extension ItemDisplayCoordinator: ItemDisplayCoordinatorProtocol {
  
  func presentMore(_ viewController: UIViewController, model: ItemDisplay) {
    viewController.present(
      factory.makeItemDisplayDetailView(model: model),
      animated: true, completion: nil)
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
