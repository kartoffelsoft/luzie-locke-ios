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
  let storage:        StorageService
  let firebaseAuth:   FirebaseAuthable
  let backendClient:  BackendAPIClient
  
  init(coordinator:   LoginCoordinator,
       storage:       StorageService,
       firebaseAuth:  FirebaseAuthable,
       backendClient: BackendAPIClient) {
    self.coordinator    = coordinator
    self.storage        = storage
    self.firebaseAuth   = firebaseAuth
    self.backendClient  = backendClient
  }
  
  func performGoogleLogin(_ calller: UIViewController) {
    firebaseAuth.authenticate(calller, with: .google, completion: { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let data):
        self.backendClient.user.authenticate(uid: data.uid, token: data.token) { result in
          switch result {
          case .success(let data):
            self.storage.profile.set(data.profile)
            self.storage.accessToken.set(data.accessToken)
            self.storage.refreshToken.set(data.refreshToken)
            self.backendClient.configureTokenHeader(token: data.accessToken)

            if data.profile.location.name.isEmpty {
              DispatchQueue.main.async {
                self.coordinator.navigateToMap(selectAction: { [weak self] name, lat, lng in
                  guard let self = self else { return }
                  self.coordinator.popViewController()
                  
                  if let name = name, let lat = lat, let lng = lng {
                    self.backendClient.user.updateLocation(name: name,
                                                           lat: lat,
                                                           lng: lng) { result in
                      self.delegate?.didLogin()
                    }
                  } else {
                    self.delegate?.didLogin()
                  }
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

