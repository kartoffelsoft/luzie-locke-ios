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
    
    weak var delegate: LoginViewModelDelegate?
    
    let auth: Authable
    
    init(auth: Authable) {
        self.auth = auth
    }
    
    func performGoogleLogin(_ calller: UIViewController) {
        auth.authenticate(calller, with: .google, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success():
                self.delegate?.didLogin()
            case .failure(let error):
                self.delegate?.didReceiveError(error)
            case .none:
                ()
            }
        })
    }
}

