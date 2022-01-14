//
//  HomeCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class HomeCoordinator: NSObject, Coordinatable {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
  let factory               : Factory
  var navigationController  : UINavigationController
  
  var children = [Coordinatable]()

  init(factory:               Factory,
       navigationController:  UINavigationController) {
    self.factory              = factory
    self.navigationController = navigationController
  }
  
  func start() {
    let vm = factory.makeHomeViewModel(coordinator: self)
    let vc = factory.makeHomeViewController(viewModel: vm)
    navigationController.delegate = self
    navigationController.pushViewController(vc, animated: false)
  }
  
  func navigateToItemCreate() {
    let viewModel       = factory.makeItemCreateViewModel(coordinator: self)
    let viewController  = factory.makeItemComposeViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func navigateToItemSearch() {
    let coordinator = factory.makeItemSearchCoordinator(navigationController: navigationController)
    children.append(coordinator)
    coordinator.start()
  }
  
  func navigateToItemDisplay(itemId: String) {
    let coordinator = factory.makeItemDisplayCoordinator(navigationController: navigationController,
                                                         itemId: itemId)
    children.append(coordinator)
    coordinator.start()
  }
  
  private func childDidFinish(_ child: Coordinatable?) {
    for (index, coordinator) in children.enumerated() {
      if coordinator === child {
        children.remove(at: index)
        return
      }
    }
  }
}

extension HomeCoordinator: PopCoordinatable {
  
  func popViewController() {
    DispatchQueue.main.async {
      self.navigationController.popViewController(animated: true)
    }
  }
  
  func popToRootViewController() {}
}

extension HomeCoordinator: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard let from = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
      return
    }
    
    if navigationController.viewControllers.contains(from) {
      return
    }
    
    if let viewController = from as? ItemDisplayViewController {
      childDidFinish(viewController.coordinator)
    }
  }
}
