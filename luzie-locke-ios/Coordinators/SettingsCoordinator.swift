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
    let viewModel       = factory.makeSettingsViewModel(coordinator: self)
    let viewController  = factory.makeSettingsViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: false)
  }
  
  func navigateToUserListings() {
    let viewModel       = factory.makeUserListingsViewModel(coordinator: self)
    let viewController  = factory.makeUserListingsViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func navigateToMap(selectAction: @escaping MapViewCallback) {
    let viewController = MapViewController(mapView: MKMapView(), locationManager: CLLocationManager())
    viewController.selectAction = selectAction
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
