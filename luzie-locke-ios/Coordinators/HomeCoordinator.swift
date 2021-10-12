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
    
    var auth: Authable
    
    init(navigationController: UINavigationController, auth: Authable) {
        self.navigationController = navigationController
        self.auth = auth
    }
    
    func start() {
        let vc = HomeViewController(auth: auth)
        vc.tabBarItem   = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house.circle"),
                                       selectedImage: UIImage(systemName: "house.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
