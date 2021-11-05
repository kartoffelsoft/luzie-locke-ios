//
//  File.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

protocol Coordinator: AnyObject {
  var children: [Coordinator] { get set }
//  var router: Router { get }
  
  var navigationController: UINavigationController { get set }
  func start()
}

protocol CoordinatorExt: AnyObject {
  var router: Router { get }
  var children: [CoordinatorExt] { get set }

  func present(animated: Bool, onDismiss: (() -> Void)?)
  func dismiss(animated: Bool)
  func presentChildCoordinator(_ child: CoordinatorExt,
                               animated: Bool,
                               onDismiss: (()-> Void)?)
}

extension CoordinatorExt {
  
  func dismiss(animated: Bool) {
    router.dismiss(animated: true)
  }
  
  func presentChildCoordinator(_ child: CoordinatorExt,
                               animated: Bool,
                               onDismiss: (()-> Void)?) {
    children.append(child)
    child.present(animated: animated, onDismiss: { [weak self, weak child] in
      guard let self = self, let child = child else { return }
      self.removeChild(child)
      onDismiss?()
    })
  }
  
  private func removeChild(_ child: CoordinatorExt) {
    guard let index = children.firstIndex(where: { $0 === child }) else { return }
    children.remove(at: index)
  }
}
