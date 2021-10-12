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
    let auth: Authable
    
    init(auth: Authable) {
        self.auth = auth
    }
    
    func performGoogleLogin(_ calller: UIViewController) {
        auth.authenticate(calller, with: .google, completion: { result in
            print("performGoogleLogin")
        })
    }
}
