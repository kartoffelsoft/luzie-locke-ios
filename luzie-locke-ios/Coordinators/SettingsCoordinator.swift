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
    
    var profileStorage: AnyStorage<Profile>
    
    init(navigationController: UINavigationController, profileStorage: AnyStorage<Profile>) {
        self.navigationController = navigationController
        self.profileStorage = profileStorage
    }
    
    func start() {
        let vc = SettingsViewController(profileStorage: profileStorage)
        vc.tabBarItem   = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "person.crop.circle"),
                                       selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
