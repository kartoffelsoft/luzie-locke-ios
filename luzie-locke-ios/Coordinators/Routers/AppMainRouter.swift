//
//  AppDelegateRouter.swift
//  luzie-locke-ios
//
//  Created by Harry on 05.11.21.
//

import UIKit

class AppMainRouter: Router {
  
  let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func present(_ viewController: UIViewController, animated: Bool, onDismiss: (() -> Void)?) {
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  func dismiss(animated: Bool) {}
}
