//
//  SignUpViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.12.21.
//

import Foundation

class SignUpViewModel {
  
  let coordinator: LoginCoordinator

  init(coordinator: LoginCoordinator) {
    self.coordinator = coordinator
  }
  
  func didTapGoToLogin() {
    coordinator.popViewController()
  }
}
