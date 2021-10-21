//
//  CoordinatorMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 12.10.21.
//

import UIKit
@testable import luzie_locke_ios

class CoordinatorMock: Coordinator {
  var children = [Coordinator]()
  var navigationController = UINavigationController()
  
  func start() {
    let vc = UIViewController()
    navigationController.pushViewController(vc, animated: false)
  }
}
