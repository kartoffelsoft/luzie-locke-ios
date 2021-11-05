//
//  Router.swift
//  luzie-locke-ios
//
//  Created by Harry on 05.11.21.
//

import UIKit

protocol Router: AnyObject {
  func present(_ viewController: UIViewController, animated: Bool, onDismiss: (() -> Void)?)
  func dismiss(animated: Bool)
}
