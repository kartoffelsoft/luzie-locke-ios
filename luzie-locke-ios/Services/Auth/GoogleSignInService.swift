//
//  GoogleSignInService.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import UIKit
import Firebase
import GoogleSignIn

class GoogleSignInService {
    
    func signIn(_ caller: UIViewController, completion: @escaping (Result<(uid: String, token: String), LLError>?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(with: config, presenting: caller) { user, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                completion(.failure(.unableToComplete))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let _ = error {
                    completion(.failure(.unableToComplete))
                    return
                }
                
                if let uid = authResult?.user.uid {
                    completion(.success((uid: uid, token: authentication.accessToken)))
                }
            }
        }
    }
}
