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
  
  typealias Factory = CoordinatorFactory & ViewControllerFactory & ViewModelFactory
  
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
