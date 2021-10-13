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
    
    var userStorage: UserStorable
    
    init(navigationController: UINavigationController, userStorage: UserStorable) {
        self.navigationController = navigationController
        self.userStorage = userStorage
    }
    
    func start() {
        let vc = SearchViewController(userStorage: userStorage)
        vc.tabBarItem   = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass.circle"),
                                       selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
