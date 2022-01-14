//
//  ChatCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class MessagesCoordinator: Coordinatable {
  
  typealias Factory = CommunicationViewFactory
  
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
  
  func navigateToChat(remoteUserId: String, itemId: String) {
    navigationController.pushViewController(
      factory.makeMessageView(remoteUserId: remoteUserId, itemId: itemId),
      animated: true
    )
  }
}
