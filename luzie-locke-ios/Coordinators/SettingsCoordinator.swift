//
//  SettingsCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import Foundation

import UIKit

class SettingsCoordinator: Coordinator {
  
  var children = [Coordinator]()
  var navigationController: UINavigationController
  
  let openHttpClient: OpenHTTPClient
  let profileStorage: AnyStorage<Profile>
  
  init(navigationController: UINavigationController, openHttpClient: OpenHTTPClient, profileStorage: AnyStorage<Profile>) {
    self.navigationController = navigationController
    self.openHttpClient       = openHttpClient
    self.profileStorage       = profileStorage
  }
  
  func start() {
    let vc = SettingsViewController(openHttpClient: openHttpClient, profileStorage: profileStorage)
    vc.tabBarItem = UITabBarItem(title: "Settings",
                                 image: Images.settings,
                                 selectedImage: Images.settings)
    navigationController.pushViewController(vc, animated: false)
  }
}
