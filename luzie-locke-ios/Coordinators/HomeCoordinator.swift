//
//  HomeCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class HomeCoordinator: NSObject, Coordinator {
  
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
    navigationController.delegate = self
    navigationController.pushViewController(vc, animated: false)
  }
  
  func navigateToItemCreate() {
    let vm = factory.makeItemCreateViewModel(coordinator: self)
    let vc = factory.makeItemCreateViewController(viewModel: vm)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func navigateToItemSearch() {
    let coordinator = factory.makeItemSearchCoordinator(navigationController: navigationController)
    children.append(coordinator)
    coordinator.start()
  }
  
  func navigateToItemDisplay(id: String) {
    let coordinator = factory.makeItemDisplayCoordinator(navigationController: navigationController,
                                                         id: id)
    children.append(coordinator)
    coordinator.start()
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
  
  private func childDidFinish(_ child: Coordinator?) {
    for (index, coordinator) in children.enumerated() {
      if coordinator === child {
        children.remove(at: index)
        print("removed", children)
        return
      }
    }
  }
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
