//
//  File.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get set }
  var children: [Coordinator] { get set }
  func start()
}
