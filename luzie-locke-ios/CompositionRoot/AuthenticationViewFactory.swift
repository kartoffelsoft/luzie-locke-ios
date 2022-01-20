//
//  AuthenticationViewFactory.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.01.22.
//

import UIKit

protocol AuthenticationViewFactory {
  
  func makeSignUpView(coordinator: LoginCoordinator) -> SignUpViewController
}

extension CompositionRoot: AuthenticationViewFactory {

  func makeSignUpView(coordinator: LoginCoordinator) -> SignUpViewController {
    let vc = SignUpViewController()
    vc.viewModel = SignUpViewModel(coordinator: coordinator)
    return vc
  }
}
