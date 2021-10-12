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

protocol Authable {
    func isAuthencated() -> Bool
    func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<Void, LLError>?) -> Void)
}

class AuthService: Authable {
    
    var user: User?
    
    let google: GoogleSignInService
    let backend: BackendAuthService
    
    init(backend: BackendAuthService, google: GoogleSignInService) {
        self.google = google
        self.backend = backend
    }
    
    func isAuthencated() -> Bool {
//        return Auth.auth().currentUser != nil
        return false
    }
    
    func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<Void, LLError>?) -> Void) {
        switch provider {
        case .google:
            google.signIn(caller) { [weak self] result in
                guard let self = self else {
                    completion(.failure(.unableToComplete))
                    return
                }
                
                switch result {
                case .success(let data):
                    self.backend.authenticate(uid: data.uid, token: data.token) { [weak self] result in
                        guard let self = self else {
                            completion(.failure(.unableToComplete))
                            return
                        }
                        
                        switch result {
                        case .success(let user):
                            self.user = user
                            completion(.success(()))
                            
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
    }
}
