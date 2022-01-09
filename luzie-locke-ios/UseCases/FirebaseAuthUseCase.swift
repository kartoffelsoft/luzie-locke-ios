//
//  FirebaseAuthUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import UIKit
import Firebase
import GoogleSignIn

enum SignInProvider {
  case google
}

protocol FirebaseAuthUseCaseProtocol {
  
  func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<(uid: String, token: String), LLError>?) -> Void)
  func isAuthenticated() -> Bool
  func logout()
}

class FirebaseAuthUseCase: FirebaseAuthUseCaseProtocol {
  
  let google: GoogleSignInUseCase
  
  init(google: GoogleSignInUseCase) {
    self.google = google
  }
  
  func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<(uid: String, token: String), LLError>?) -> Void) {
    switch provider {
    case .google:
      google.signIn(caller) { result in
        switch result {
        case .success(let data):
          completion(.success(data))
        case .failure(let error):
          completion(.failure(error))
        case .none:
          ()
        }
      }
    }
  }
  
  func isAuthenticated() -> Bool {
    return Firebase.Auth.auth().currentUser != nil
  }
  
  func logout() {
    try? Firebase.Auth.auth().signOut()
  }
}
