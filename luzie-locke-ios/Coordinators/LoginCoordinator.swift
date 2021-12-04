//
//  LoginCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit
import MapKit

class LoginCoordinator: Coordinator {
  
  typealias Factory = ViewControllerFactory & ViewModelFactory
  
  let factory               : Factory
  var navigationController  : UINavigationController
  
  var children = [Coordinator]()
  
  init(factory:               Factory,
       navigationController:  UINavigationController) {
    self.factory              = factory
    self.navigationController = navigationController

  }

  func start() {
    let vm = factory.makeLoginViewModel(coordinator: self)
    let vc = factory.makeLoginViewController(viewModel: vm)
    
    self.navigationController.modalPresentationStyle = .fullScreen
    self.navigationController.pushViewController(vc, animated: true)
  }
  
  func navigateToVerifyNeighborhood(selectAction: @escaping MapViewCallback) {
    let vc = VerifyNeighborhoodViewController(mapView: MKMapView(), locationManager: CLLocationManager())
    vc.selectAction = selectAction
    navigationController.pushViewController(vc, animated: true)
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
