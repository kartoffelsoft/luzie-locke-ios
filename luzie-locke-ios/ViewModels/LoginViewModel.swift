//
//  LoginViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import Foundation
import Firebase
import GoogleSignIn

class LoginViewModel {
    let authService: AuthService?
    
    init(authService: AuthService?) {
        self.authService = authService
    }
    
    func performGoogleLogin(_ calller: UIViewController) {
        authService?.authenticate(calller, with: .google, completion: { result in
            print("performGoogleLogin")
        })
    }
}
