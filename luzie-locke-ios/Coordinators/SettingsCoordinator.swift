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
    
    var auth: Authable
    
    init(navigationController: UINavigationController, auth: Authable) {
        self.navigationController = navigationController
        self.auth = auth
    }
    
    func start() {
        let vc = SettingsViewController(auth: auth)
        vc.tabBarItem   = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "person.crop.circle"),
                                       selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
