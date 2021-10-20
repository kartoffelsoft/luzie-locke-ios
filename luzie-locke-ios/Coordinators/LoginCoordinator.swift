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
  
  let storage:        StorageService
  let firebaseAuth:   FirebaseAuthable
  let backendClient:  BackendAPIClient
  
  init(navigationController:  UINavigationController,
       storage:               StorageService,
       firebaseAuth:          FirebaseAuthable,
       backendClient:         BackendAPIClient) {
    
    self.navigationController   = navigationController
    self.storage                = storage
    self.firebaseAuth           = firebaseAuth
    self.backendClient          = backendClient
    
    self.navigationController.modalPresentationStyle = .fullScreen
    
    let vm = LoginViewModel(coordinator: self, storage: storage, firebaseAuth: firebaseAuth, backendClient: backendClient)
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
