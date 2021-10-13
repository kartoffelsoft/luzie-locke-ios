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
    
    var userStorage: UserStorable
    
    init(navigationController: UINavigationController, userStorage: UserStorable) {
        self.navigationController = navigationController
        self.userStorage = userStorage
    }
    
    func start() {
        let vc = SettingsViewController(userStorage: userStorage)
        vc.tabBarItem   = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "person.crop.circle"),
                                       selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
