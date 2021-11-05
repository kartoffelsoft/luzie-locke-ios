//
//  AppMainCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 05.11.21.
//

import Foundation

class AppMainCoordinator: CoordinatorExt {

  typealias Factory = ViewControllerFactory
  let factory: Factory
  
  let router: Router
  var children: [CoordinatorExt] = []

  init(factory: Factory, router: Router) {
    self.factory  = factory
    self.router   = router
  }
  
  func present(animated: Bool, onDismiss: (() -> Void)?) {
    let viewController = factory.makeMainTabBarController()
    router.present(viewController, animated: animated, onDismiss: onDismiss)
  }
}

//
//extension AppMainCoordinator: MainTabBarControllerDelegate {
//  public func homeViewControllerDidPressScheduleAppointment(_ viewController: HomeViewController) {
//    let router = ModalNavigationRouter(parentViewController: viewController)
//    let coordinator = PetAppointmentBuilderCoordinator(router: router)
//    presentChild(coordinator, animated: true)
//  }
//}
