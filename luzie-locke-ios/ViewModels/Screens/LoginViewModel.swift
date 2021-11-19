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
  func didGetError(_ error: LLError)
}

class LoginViewModel {
  
  weak var delegate:          LoginViewModelDelegate?
  
  let coordinator:            LoginCoordinator
  let auth:                   Auth
  let localProfileRepository: LocalProfileRepositoryProtocol
  let backendApiClient:       BackendAPIClient
  
  init(coordinator:             LoginCoordinator,
       auth:                    Auth,
       localProfileRepository:  LocalProfileRepositoryProtocol,
       backendApiClient:        BackendAPIClient) {
    self.coordinator            = coordinator
    self.auth                   = auth
    self.localProfileRepository = localProfileRepository
    self.backendApiClient       = backendApiClient
  }
  
  func performGoogleLogin(_ calller: UIViewController) {
    auth.authenticate(calller, with: .google) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let profile):
        guard let name = profile.locationName else { return }
        
        if name.isEmpty {
          DispatchQueue.main.async {
            self.coordinator.navigateToMap(selectAction: { [weak self] name, lat, lng in
              guard let self = self else { return }
              self.coordinator.popViewController()
              
              if let name = name, let lat = lat, let lng = lng {
                self.backendApiClient.userApi.updateLocation(name: name,
                                                          lat: lat,
                                                          lng: lng) { result in
                  switch result {
                  case .success(let profile):
                    self.localProfileRepository.update(profile)
                  case .failure:
                    ()
                  case .none:
                    ()
                  }
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
        self.delegate?.didGetError(error)
      case .none:
        ()
      }
    }
  }
}
