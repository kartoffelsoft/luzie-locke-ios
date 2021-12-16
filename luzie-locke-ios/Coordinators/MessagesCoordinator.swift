//
//  ChatCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class MessagesCoordinator: Coordinatable {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
  var navigationController: UINavigationController
  var children = [Coordinatable]()
  
  private let factory: Factory
  
  init(factory:               Factory,
       navigationController:  UINavigationController) {
    self.factory              = factory
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController        = factory.makeMessagesViewController()
    viewController.viewModel  = factory.makeMessagesViewModel(coordinator: self)
    navigationController.pushViewController(viewController, animated: false)
  }
  
  func navigateToChat(remoteUserId: String, itemId: String) {
    let viewController = factory.makeChatViewController()
    viewController.viewModel = factory.makeChatViewModel(remoteUserId: remoteUserId, itemId: itemId)
    navigationController.pushViewController(viewController, animated: true)
  }
}
