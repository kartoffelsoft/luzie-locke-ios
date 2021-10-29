//
//  SettingsCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import Foundation

import UIKit
import MapKit

class SettingsCoordinator: Coordinator {
  
  var children = [Coordinator]()
  var navigationController: UINavigationController
  
  let auth:             Auth
  let profileStorage:   AnyStorage<User>
  let openHttpClient:   OpenHTTP
  let backendApiClient: BackendAPIClient
  
  init(navigationController:  UINavigationController,
       auth:                  Auth,
       profileStorage:        AnyStorage<User>,
       openHttpClient:        OpenHTTP,
       backendApiClient:      BackendAPIClient) {
    self.navigationController = navigationController
    self.auth                 = auth
    self.profileStorage       = profileStorage
    self.openHttpClient       = openHttpClient
    self.backendApiClient     = backendApiClient
    
    let vm = SettingsViewModel(coordinator: self, auth: auth, profileStorage: profileStorage, openHttpClient: openHttpClient, backendApiClient: backendApiClient)
    let vc = SettingsViewController(viewModel: vm)
    vc.tabBarItem = UITabBarItem(title: nil,
                                 image: Images.settings,
                                 selectedImage: Images.settings)
    navigationController.pushViewController(vc, animated: false)
  }

  func start() {
  }
  
  func navigateToMap(selectAction: @escaping MapViewCallback) {
    let vc = MapViewController(mapView: MKMapView(), locationManager: CLLocationManager())
    vc.selectAction = selectAction
    navigationController.pushViewController(vc, animated: true)
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
