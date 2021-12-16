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
  
  weak var delegate:      LoginViewModelDelegate?
  
  let coordinator:        LoginCoordinator
  let auth:               Auth
  let myProfileUseCase:   MyProfileUseCaseProtocol
  let backendApiClient:   BackendAPIClient
  
  init(coordinator:       LoginCoordinator,
       auth:              Auth,
       myProfileUseCase:  MyProfileUseCaseProtocol,
       backendApiClient:  BackendAPIClient) {
    self.coordinator      = coordinator
    self.auth             = auth
    self.myProfileUseCase = myProfileUseCase
    self.backendApiClient = backendApiClient
  }
  
  private func confirmLogin() {
    if auth.isAuthenticated() {
      if myProfileUseCase.isLocationSet() {
        delegate?.didLogin()
        NotificationCenter.default.post(name: .didUpdateItem, object: nil)
        NotificationCenter.default.post(name: .didLogin, object: nil)
      } else {
        DispatchQueue.main.async {
          self.coordinator.navigateToVerifyNeighborhood()
        }
      }
    }
  }
  
  public func viewDidAppear() {
    confirmLogin()
  }
  
  func performGoogleLogin(_ calller: UIViewController) {
    auth.authenticate(calller, with: .google) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(_):
        self.confirmLogin()
//        guard let name = profile.city else { return }
//
//        if name.isEmpty {
//          DispatchQueue.main.async {
//
          
//          selectAction: { [weak self] city, lat, lng in
//              guard let self = self else { return }
//              self.coordinator.popViewController()
//
//              if let city = city, let lat = lat, let lng = lng {
//                self.backendApiClient.userApi.updateLocation(city: city,
//                                                             lat: lat,
//                                                             lng: lng) { result in
//                  switch result {
//                  case .success(let profile):
//                    self.localProfileRepository.update(profile)
//                  case .failure:
//                    ()
//                  case .none:
//                    ()
//                  }
//                  self.delegate?.didLogin()
//                  NotificationCenter.default.post(name: .didUpdateItem, object: nil)
//                  NotificationCenter.default.post(name: .didLogin, object: nil)
//                }
//              } else {
//                self.delegate?.didLogin()
//                NotificationCenter.default.post(name: .didUpdateItem, object: nil)
//                NotificationCenter.default.post(name: .didLogin, object: nil)
//              }
//            })
//          }
//      }
//        } else {
//          self.delegate?.didLogin()
//          NotificationCenter.default.post(name: .didUpdateItem, object: nil)
//          NotificationCenter.default.post(name: .didLogin, object: nil)
//        }
      case .failure(let error):
        self.delegate?.didGetError(error)
      case .none:
        ()
      }
    }
  }
  
  func didTapGoToSignUp() {
    coordinator.navigateToSignUp()
  }
}
