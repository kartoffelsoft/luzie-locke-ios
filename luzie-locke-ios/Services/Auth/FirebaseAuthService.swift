//
//  AuthManager.swift
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

protocol FirebaseAuthable {
    func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<(uid: String, token: String), LLError>?) -> Void)
}

class FirebaseAuthService: FirebaseAuthable {
    
    let google: GoogleSignInService
    
    init(google: GoogleSignInService) {
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
}
