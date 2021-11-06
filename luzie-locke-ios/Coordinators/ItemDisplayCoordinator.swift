//
//  ItemDisplayCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.11.21.
//

//import UIKit
//
//class HomeCoordinator: NSObject, Coordinator {
//  
//  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
//  let factory               : Factory
//  var navigationController  : UINavigationController
//
//  var children = [Coordinator]()
//  
//  private var onDismissForViewController: [UIViewController: (()->Void)] = [:]
//  
//  init(factory:               Factory,
//       navigationController:  UINavigationController) {
//    self.factory              = factory
//    self.navigationController = navigationController
//  }
//  
//  func start() {
//    let viewModel       = factory.makeHomeViewModel()
//    let viewController  = factory.makeHomeViewController(viewModel: viewModel)
//    viewModel.route     = self
//    navigationController.pushViewController(viewController, animated: false)
//  }
//  
//  func childDidFinish(_ child: Coordinator?) {
//    for (index, coordinator) in children.enumerated() {
//      if coordinator === child {
//        children.remove(at: index)
//      }
//    }
//  }
//}
//
//extension HomeCoordinator: UINavigationControllerDelegate {
//  
//  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//    guard let from = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//      return
//    }
//    
//    if navigationController.viewControllers.contains(from) {
//      return
//    }
//    
////    if let viewController = from as? ItemCreateViewController {
////      childDidFinish(viewController)
////    }
//  }
//}
//
//extension HomeCoordinator: HomeViewModelRouteDelegate {
//  func didRequestItemCreateScreen() {
//    let vm = factory.makeItemCreateViewModel(coordinator: self)
//    let vc = factory.makeItemCreateViewController(viewModel: vm)
//    navigationController.pushViewController(vc, animated: true)
//  }
//  
//  func didRequestItemDisplayScreen(id: String) {
//    let vm = factory.makeItemDisplayViewModel(coordinator: self, id: id)
//    let vc = factory.makeItemDisplayViewController(viewModel: vm)
//    navigationController.pushViewController(vc, animated: true)
//  }
//}
