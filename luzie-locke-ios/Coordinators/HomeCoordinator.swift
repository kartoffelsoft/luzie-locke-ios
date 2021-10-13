//
//  HomeCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class HomeCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    var userStorage: UserStorage
    
    init(navigationController: UINavigationController, userStorage: UserStorage) {
        self.navigationController = navigationController
        self.userStorage = userStorage
    }
    
    func start() {
        let vc = HomeViewController(userStorage: userStorage)
        vc.tabBarItem   = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house.circle"),
                                       selectedImage: UIImage(systemName: "house.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
