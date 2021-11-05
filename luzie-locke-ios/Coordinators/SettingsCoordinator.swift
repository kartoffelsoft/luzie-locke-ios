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
  
  typealias Factory = ViewControllerFactory & ViewModelFactory
  
  let factory               : Factory
  var navigationController  : UINavigationController
  
  var children = [Coordinator]()

  init(factory                : Factory,
       navigationController   : UINavigationController) {
    self.factory              = factory
    self.navigationController = navigationController
  }

  func start() {
    let vm = factory.makeSettingsViewModel(coordinator: self)
    let vc = factory.makeSettingsViewController(viewModel: vm)

    navigationController.pushViewController(vc, animated: false)
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
