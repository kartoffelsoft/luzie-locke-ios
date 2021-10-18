//
//  LoginViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import Foundation
import Firebase
import GoogleSignIn

protocol LoginViewModelDelegate: AnyObject {
    func didLogin()
    func didReceiveError(_ error: LLError)
}

class LoginViewModel {
    
    weak var delegate:  LoginViewModelDelegate?
    
    let coordinator:    LoginCoordinator
    let userStorage:    UserStorage
    let firebaseAuth:   FirebaseAuthable
    let backendAuth:    BackendAuthable
    
    init(coordinator: LoginCoordinator,
         userStorage: UserStorage,
         firebaseAuth: FirebaseAuthable,
         backendAuth: BackendAuthable) {
        self.coordinator    = coordinator
        self.userStorage    = userStorage
        self.firebaseAuth   = firebaseAuth
        self.backendAuth    = backendAuth
    }
    
    func performGoogleLogin(_ calller: UIViewController) {
        firebaseAuth.authenticate(calller, with: .google, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.backendAuth.authenticate(uid: data.uid, token: data.token) { [weak self] result in
                    guard let self = self else { return }

                    switch result {
                    case .success(let user):
                        self.userStorage.set(user)

                        if user.profile.location.name.isEmpty {
                            DispatchQueue.main.async {
                                self.coordinator.navigateToMap(selectAction: { [weak self] name, lat, lng in
                                    print(name ?? "Not selected")
                                    print(lat ?? 0)
                                    print(lng ?? 0)
                                    self?.coordinator.popViewController()
                                })
                            }
                        } else {
                            self.delegate?.didLogin()
                        }
                    case .failure(let error):
                        self.delegate?.didReceiveError(error)
                    case .none:
                        ()
                    }
                }
            case .failure(let error):
                self.delegate?.didReceiveError(error)
            case .none:
                ()
            }
        })
    }
}

