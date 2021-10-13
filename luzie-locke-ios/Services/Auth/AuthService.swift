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
    func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<Void, LLError>?) -> Void)
}

class AuthService: Authable {
    
    let userStorage: UserStorage
    let google: GoogleSignInService
    let backend: BackendAuthService
    
    init(userStorage: UserStorage, backend: BackendAuthService, google: GoogleSignInService) {
        self.userStorage = userStorage
        self.google = google
        self.backend = backend
    }
    
    func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<Void, LLError>?) -> Void) {
        switch provider {
        case .google:
            google.signIn(caller) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    self.backend.authenticate(uid: data.uid, token: data.token) { [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success(let user):
                            self.userStorage.set(user)
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
