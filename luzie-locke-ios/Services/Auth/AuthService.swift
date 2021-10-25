//
//  AuthService.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import UIKit

protocol Authable {
  
  func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<Profile, LLError>?) -> Void)
  
  func isAuthenticated() -> Bool
}

class AuthService: Authable {
  
  let firebaseAuth: FirebaseAuthable
  let backendAuth:  BackendAuthable
  
  init(firebaseAuth: FirebaseAuthable, backendAuth: BackendAuthable) {
    self.firebaseAuth = firebaseAuth
    self.backendAuth  = backendAuth
  }
  
  func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<Profile, LLError>?) -> Void) {
    firebaseAuth.authenticate(caller, with: .google) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.backendAuth.authenticate(uid: data.uid, token: data.token) { result in
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
    return firebaseAuth.isAuthenticated() && backendAuth.isAuthenticated()
  }
  
  func logout() {
    firebaseAuth.logout()
    backendAuth.logout()
  }
}
