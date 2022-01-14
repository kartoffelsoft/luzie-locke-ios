//
//  SettingsCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import Foundation

import UIKit
import SwiftUI
import MapKit

protocol SettingsCoordinatorProtocol {
  
  func navigateToUserListings()
  func navigateToUserPurchases()
  func navigateToUserFavorites()
  func navigateToNeighborhooodSetting()
  func navigateToVerifyNeighborhood()
  func navigateToItemDisplay(itemId: String)
}

class SettingsCoordinator: Coordinatable {
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory & ItemViewFactory
  
  let factory               : Factory
  var navigationController  : UINavigationController
  
  var children = [Coordinatable]()

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
}

extension SettingsCoordinator: SettingsCoordinatorProtocol {
  
  func navigateToUserListings() {
    navigationController.pushViewController(
      factory.makeUserListingsView(coordinator: self),
      animated: true)
  }
  
  func navigateToUserPurchases() {
    navigationController.pushViewController(
      factory.makeUserPurchasesView(coordinator: self),
      animated: true)
  }
  
  func navigateToUserFavorites() {
    navigationController.pushViewController(
      factory.makeUserFavoritesView(coordinator: self),
      animated: true)
  }

  func navigateToNeighborhooodSetting() {
    let viewModel      = factory.makeNeighborhoodSettingViewModel(coordinator: self)
    let viewController = UIHostingController(rootView: NeighborhoodSettingView().environmentObject(viewModel))
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func navigateToVerifyNeighborhood() {
    let viewModel      = factory.makeVerifyNeighborhoodViewModel(coordinator: self)
    let viewController = UIHostingController(rootView: VerifyNeighborhoodView().environmentObject(viewModel))
    navigationController.pushViewController(viewController, animated: true)
  }

  func navigateToItemDisplay(itemId: String) {
    let coordinator = factory.makeItemDisplayCoordinator(
      navigationController: navigationController,
      itemId: itemId)
    
    children.append(coordinator)
    coordinator.start()
  }
}

extension SettingsCoordinator: PopCoordinatable {

  func popViewController() {
    DispatchQueue.main.async {
      self.navigationController.popViewController(animated: true)
    }
  }
  
  func popToRootViewController() {}
}
