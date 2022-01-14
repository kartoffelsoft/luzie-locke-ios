//
//  ChatCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

protocol MessagesCoordinatorProtocol {
  func navigateToCommunication(remoteUserId: String, itemId: String)
}

class MessagesCoordinator: Coordinatable {
  
  typealias Factory = CoordinatorFactory & CommunicationViewFactory
  
  var navigationController: UINavigationController
  var children = [Coordinatable]()
  
  private let factory: Factory
  
  init(factory:               Factory,
       navigationController:  UINavigationController) {
    self.factory              = factory
    self.navigationController = navigationController
  }
  
  func start() {
    navigationController.pushViewController(
      factory.makeMessagesView(coordinator: self),
      animated: false)
  }
}

extension MessagesCoordinator: MessagesCoordinatorProtocol {

  func navigateToCommunication(remoteUserId: String, itemId: String) {
    let coordinator = factory.makeCommunicationCoordinator(navigationController: navigationController,
                                                           remoteUserId: remoteUserId,
                                                           itemId: itemId)
    children.append(coordinator)
    coordinator.start()
  }
}
