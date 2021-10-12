//
//  SearchCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class SearchCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    var auth: Authable
    
    init(navigationController: UINavigationController, auth: Authable) {
        self.navigationController = navigationController
        self.auth = auth
    }
    
    func start() {
        let vc = SearchViewController(auth: auth)
        vc.tabBarItem   = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass.circle"),
                                       selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
