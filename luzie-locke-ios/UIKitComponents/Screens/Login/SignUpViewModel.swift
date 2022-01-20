//
//  SignUpViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.12.21.
//

import Foundation
import Combine

class SignUpViewModel {
  
  let coordinator: LoginCoordinator
  
  @Published var name = ""
  @Published var email = ""
  @Published var password = ""
  @Published var passwordAgain = ""
  
  var isValidName: AnyPublisher<(Bool, String?), Never> {
    return $name
      .map { name in
        return name.count > 0 ? (true, nil) : (false, nil)
      }
      .eraseToAnyPublisher()
  }
  
  var isValidEmail: AnyPublisher<(Bool, String?), Never> {
    return $email
      .map { email in
        if email.count == 0 {
          return (false, nil)
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if !emailPredicate.evaluate(with: email) {
          return (false, "Not a proper Email address")
        }
        
        return (true, nil)
      }
      .eraseToAnyPublisher()
//    return $email
//      .debounce(for: 0.5, scheduler: RunLoop.main)
//      .removeDuplicates()
//      .flatMap { email in
//        return Future { promise in
//          self.emailAvailable(email) { available in
//            promise(.success(available ? email : nil))
//          }
//        }
//      }
//      .eraseToAnyPublisher()
    
  }
  
//  func emailAvailable(_ email: String, completion: (Bool) -> Void) {
//    completion(true) // Our fake asynchronous backend service
//  }
  
  var isValidPassword: AnyPublisher<(Bool, String?), Never> {
    return Publishers.CombineLatest($password, $passwordAgain)
      .map { password, passwordAgain in
        if password.count == 0 {
          return (false, nil)
        }
        
        if password.count < 6 {
          return (false, "Password should be at least 6 characters long.")
        }
        
        if password != passwordAgain {
          return (false, "Passwords should be the same.")
        }
        
        return (true, nil)
      }
      .eraseToAnyPublisher()
  }
  
  var isSignUpButtonEnabled: AnyPublisher<Bool, Never> {
    return Publishers.CombineLatest3(isValidName, isValidEmail, isValidPassword)
      .receive(on: RunLoop.main)
      .map { isValidName, isValidEmail, isValidPassword in
        return isValidName.0 && isValidEmail.0 && isValidPassword.0
      }
      .eraseToAnyPublisher()
  }
  
  var formErrorText: AnyPublisher<String?, Never> {
    return Publishers.CombineLatest3(isValidName, isValidEmail, isValidPassword)
      .receive(on: RunLoop.main)
      .map { isValidName, isValidEmail, isValidPassword in
        if let errorText = isValidName.1 { return errorText }
        if let errorText = isValidEmail.1 { return errorText }
        if let errorText = isValidPassword.1 { return errorText }
        return nil
      }
      .eraseToAnyPublisher()
  }
  
  init(coordinator: LoginCoordinator) {
    self.coordinator = coordinator
  }
  
  func didTapGoToLogin() {
    coordinator.popViewController()
  }
}
