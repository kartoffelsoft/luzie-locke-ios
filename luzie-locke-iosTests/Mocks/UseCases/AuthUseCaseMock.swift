//
//  AuthManagerMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 10.10.21.
//

import UIKit

@testable import luzie_locke_ios

class AuthUseCaseMock: AuthUseCaseProtocol {
  
  var authenticated = false
  
  func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<UserProfile, LLError>?) -> Void) {
  }
  
  func isAuthenticated() -> Bool {
    return authenticated
  }
  
  func logout() {
    
  }
  
  func setAuthStateTo(_ state: Bool) {
    authenticated = state
  }
}
