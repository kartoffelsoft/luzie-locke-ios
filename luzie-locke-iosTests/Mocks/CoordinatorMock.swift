//
//  CoordinatorMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 12.10.21.
//

import UIKit
@testable import luzie_locke_ios

class CoordinatorMock: Coordinatable {
  var children = [Coordinatable]()
  var navigationController = UINavigationController()
  
  func start() {
    let vc = UIViewController()
    navigationController.pushViewController(vc, animated: false)
  }
}
