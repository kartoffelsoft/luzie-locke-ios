//
//  LoginCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit
import MapKit
import SwiftUI

class LoginCoordinator: Coordinatable {
  
  typealias Factory = ViewControllerFactory & ViewModelFactory
  
  let factory               : Factory
  var navigationController  : UINavigationController
  
  var children = [Coordinatable]()
  
  init(factory:               Factory,
       navigationController:  UINavigationController) {
    self.factory              = factory
    self.navigationController = navigationController
  }

  func start() {
    let vm = factory.makeLoginViewModel(coordinator: self)
    let vc = factory.makeLoginViewController(viewModel: vm)
    
    self.navigationController.modalPresentationStyle = .fullScreen
    self.navigationController.pushViewController(vc, animated: true)
  }
  
  func navigateToVerifyNeighborhood() {
    let viewModel      = factory.makeVerifyNeighborhoodViewModel(coordinator: self)
    let viewController = UIHostingController(rootView: VerifyNeighborhoodView().environmentObject(viewModel))
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func navigateToSignUp() {
    let viewModel       = factory.makeSignUpViewModel(coordinator: self)
    let viewController  = factory.makeSignUpViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}

extension LoginCoordinator: PopCoordinatable {
  
  func popViewController() {
    DispatchQueue.main.async {
      self.navigationController.popViewController(animated: true)
    }
  }
  
  func popToRootViewController() {}
}
