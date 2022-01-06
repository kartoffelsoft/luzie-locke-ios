//
//  LoginViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import Foundation
import Firebase
import GoogleSignIn

protocol LoginViewModelDelegate: AnyObject {
  
  func didLogin()
  func didGetError(_ error: LLError)
}

class LoginViewModel {
  
  weak var delegate:      LoginViewModelDelegate?
  
  let coordinator:        LoginCoordinator
  let auth:               Auth
  let myProfileUseCase:   MyProfileUseCaseProtocol
  let backendApiClient:   BackendAPIClient
  
  init(coordinator:       LoginCoordinator,
       auth:              Auth,
       myProfileUseCase:  MyProfileUseCaseProtocol,
       backendApiClient:  BackendAPIClient) {
    self.coordinator      = coordinator
    self.auth             = auth
    self.myProfileUseCase = myProfileUseCase
    self.backendApiClient = backendApiClient
  }
  
  private func confirmLogin() {
    if auth.isAuthenticated() {
      if myProfileUseCase.isLocationSet() {
        delegate?.didLogin()
        NotificationCenter.default.post(name: .didUpdateItem, object: nil)
        NotificationCenter.default.post(name: .didLogin, object: nil)
      } else {
        DispatchQueue.main.async {
          self.coordinator.navigateToVerifyNeighborhood()
        }
      }
    }
  }
  
  public func viewDidAppear() {
    confirmLogin()
  }
  
  func performGoogleLogin(_ calller: UIViewController) {
    auth.authenticate(calller, with: .google) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(_):
        self.confirmLogin()
      case .failure(let error):
        self.delegate?.didGetError(error)
      case .none:
        ()
      }
    }
  }
  
  func didTapGoToSignUp() {
    coordinator.navigateToSignUp()
  }
}
