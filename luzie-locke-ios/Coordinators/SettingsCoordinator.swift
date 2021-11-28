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
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
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
  
  func navigateToUserPurchases() {
    let viewModel       = factory.makeUserPurchasesViewModel(coordinator: self)
    let viewController  = factory.makeUserPurchasesViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func navigateToUserFavorites() {
    let viewModel       = factory.makeUserFavoritesViewModel(coordinator: self)
    let viewController  = factory.makeUserFavoritesViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func navigateToMap(selectAction: @escaping MapViewCallback) {
    let viewController = MapViewController(mapView: MKMapView(), locationManager: CLLocationManager())
    viewController.selectAction = selectAction
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func navigateToItemDisplay(id: String) {
    let coordinator = factory.makeItemDisplayCoordinator(
      navigationController: navigationController,
      id: id)
    
    children.append(coordinator)
    coordinator.start()
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
