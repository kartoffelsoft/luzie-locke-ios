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
    
    var profileStorage: AnyStorage<Profile>
    
    init(navigationController: UINavigationController, profileStorage: AnyStorage<Profile>) {
        self.navigationController = navigationController
        self.profileStorage = profileStorage
    }
    
    func start() {
        let vc = SearchViewController(profileStorage: profileStorage)
        vc.tabBarItem   = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass.circle"),
                                       selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
