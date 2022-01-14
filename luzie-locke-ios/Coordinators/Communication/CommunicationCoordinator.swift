//
//  CommunicationCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 14.01.22.
//

import UIKit

protocol CommunicationCoordinatorProtocol {
  
  func navigateToItemDisplay(itemId: String)
}

class CommunicationCoordinator: NSObject, Coordinatable {
  
  typealias Factory = CoordinatorFactory & CommunicationViewFactory
  
  let factory:              Factory
  var navigationController: UINavigationController
  let remoteUserId: String
  let itemId: String
  
  var children = [Coordinatable]()
  
  init(factory: Factory, navigationController: UINavigationController, remoteUserId: String, itemId: String) {
    self.factory = factory
    self.navigationController = navigationController
    self.remoteUserId = remoteUserId
    self.itemId = itemId
  }
  
  func start() {
    navigationController.pushViewController(
      factory.makeMessageView(coordinator: self, remoteUserId: remoteUserId, itemId: itemId),
      animated: true)
  }
}

extension CommunicationCoordinator: CommunicationCoordinatorProtocol {
  
  func navigateToItemDisplay(itemId: String) {
    let coordinator = factory.makeItemDisplayCoordinator(navigationController: navigationController,
                                                         itemId: itemId)
    children.append(coordinator)
    coordinator.start()
  }
}
