//
//  ChatCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class MessagesCoordinator: Coordinator {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
  var navigationController: UINavigationController
  var children = [Coordinator]()
  
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
  
  func navigateToChat(remoteUserId: String) {
    let viewController = factory.makeChatViewController()
    viewController.viewModel = factory.makeChatViewModel(remoteUserId: remoteUserId)
    navigationController.pushViewController(viewController, animated: true)
  }
}
