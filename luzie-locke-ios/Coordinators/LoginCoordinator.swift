//
//  LoginCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit
import MapKit

class LoginCoordinator: Coordinator {
  
  var children = [Coordinator]()
  var navigationController: UINavigationController
  
  let auth:             Auth
  let storage:          StorageService
  let backendApiClient: BackendAPIClient
  
  init(navigationController:  UINavigationController,
       auth:                  Auth,
       storage:               StorageService,
       backendApiClient:      BackendAPIClient) {
    
    self.navigationController   = navigationController
    self.auth                   = auth
    self.storage                = storage
    self.backendApiClient       = backendApiClient
    
    self.navigationController.modalPresentationStyle = .fullScreen
    
    let vm = LoginViewModel(coordinator: self, auth: auth, storage: storage, backendApiClient: backendApiClient)
    let vc = LoginViewController(viewModel: vm)
    
    navigationController.pushViewController(vc, animated: false)
  }
  
  func start() {}
  
  func navigateToMap(selectAction: @escaping MapViewCallback) {
    let vc = MapViewController(mapView: MKMapView(), locationManager: CLLocationManager())
    vc.selectAction = selectAction
    navigationController.pushViewController(vc, animated: true)
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
