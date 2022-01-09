//
//  AuthUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import UIKit

protocol AuthUseCaseProtocol {
  
  func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<UserProfile, LLError>?) -> Void)
  func isAuthenticated() -> Bool
  func logout()
}

class AuthUseCase: AuthUseCaseProtocol {
  
  let firebaseAuthUseCase: FirebaseAuthUseCaseProtocol
  let backendAuthUseCase:  BackendAuthUseCaseProtocol
  
  init(firebaseAuthUseCase: FirebaseAuthUseCaseProtocol, backendAuthUseCase: BackendAuthUseCaseProtocol) {
    self.firebaseAuthUseCase = firebaseAuthUseCase
    self.backendAuthUseCase  = backendAuthUseCase
  }
  
  func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<UserProfile, LLError>?) -> Void) {
    firebaseAuthUseCase.authenticate(caller, with: .google) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.backendAuthUseCase.authenticate(uid: data.uid, token: data.token) { result in
          switch result {
          case .success(let profile):
            completion(.success(profile))
          case .failure(let error):
            completion(.failure(error))
          case .none:
            ()
          }
        }
      case .failure(let error):
        completion(.failure(error))
      case .none:
        ()
      }
    }
  }

  func isAuthenticated() -> Bool {
    return firebaseAuthUseCase.isAuthenticated() && backendAuthUseCase.isAuthenticated()
  }
  
  func logout() {
    firebaseAuthUseCase.logout()
    backendAuthUseCase.logout()
  }
}
