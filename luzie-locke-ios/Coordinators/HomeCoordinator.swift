//
//  HomeCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class HomeCoordinator: Coordinator {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
  let factory               : Factory
  var navigationController  : UINavigationController
  
  var children = [Coordinator]()

  init(factory:               Factory,
       navigationController:  UINavigationController) {
    self.factory              = factory
    self.navigationController = navigationController
  }
  
  func start() {
    let vm = factory.makeHomeViewModel(coordinator: self)
    let vc = factory.makeHomeViewController(viewModel: vm)
    navigationController.pushViewController(vc, animated: false)
  }
  
  func navigateToItemCreate() {
    let vm = factory.makeItemCreateViewModel(coordinator: self)
    let vc = factory.makeItemCreateViewController(viewModel: vm)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func navigateToItemDisplay(id: String) {
    let vm = factory.makeItemDisplayViewModel(coordinator: self, id: id)
    let vc = factory.makeItemDisplayViewController(viewModel: vm)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
