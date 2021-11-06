//
//  ModalNavigationRouter.swift
//  luzie-locke-ios
//
//  Created by Harry on 05.11.21.
//

import UIKit

class ModalNavigationRouter: NSObject {
  
  let parentViewController: UIViewController
  
  private var navigationController: UINavigationController
  private var onDismissForViewController: [UIViewController: (()->Void)] = [:]
  
  public init(parentViewController: UIViewController, navigationController: UINavigationController = UINavigationController()) {
    self.parentViewController = parentViewController
    self.navigationController = navigationController
    super.init()
    navigationController.delegate = self
  }
}

extension ModalNavigationRouter: Router {
  public func present(_ viewController: UIViewController, animated: Bool, onDismiss: (() -> Void)?) {
    onDismissForViewController[viewController] = onDismiss

    if navigationController.viewControllers.count == 0 {
      presentModally(viewController, animated: animated)
    } else {
      navigationController.pushViewController(viewController, animated: animated)
    }
  }
  
  private func presentModally(_ viewController: UIViewController, animated: Bool) {
    navigationController.setViewControllers([viewController], animated: false)
    parentViewController.present(navigationController, animated: animated, completion: nil)
  }
  
  //      self.loginCoordinator.start()
  //      self.present(self.loginCoordinator.navigationController, animated: true)
  
  public func dismiss(animated: Bool) {
    performOnDismiss(for: navigationController.viewControllers.first!)
    parentViewController.dismiss(animated: animated, completion: nil)
  }
  
  private func performOnDismiss(for viewController: UIViewController) {
    print("performOnDismissed")
    guard let onDismiss = onDismissForViewController[viewController] else { return }
    onDismiss()
    onDismissForViewController[viewController] = nil
  }
}

extension ModalNavigationRouter: UINavigationControllerDelegate {
  public func navigationController(_ navigationController: UINavigationController,
                                   didShow viewController: UIViewController,
                                   animated: Bool) {
    
    print("Yoyo")
    guard let viewController =
            navigationController.transitionCoordinator?.viewController(forKey: .from),
          !navigationController.viewControllers.contains(viewController) else {
      return
    }
    performOnDismiss(for: viewController)
  }
}
