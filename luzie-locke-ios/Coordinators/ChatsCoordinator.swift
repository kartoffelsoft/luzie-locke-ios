//
//  ChatCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class ChatsCoordinator: Coordinator {
    
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    var userStorage: UserStorable
    
    init(navigationController: UINavigationController, userStorage: UserStorable) {
        self.navigationController = navigationController
        self.userStorage = userStorage
    }
    
    func start() {
        let vc = ChatsViewController(userStorage: userStorage)
        vc.tabBarItem = UITabBarItem(title: "Chat",
                                     image: UIImage(systemName: "message.circle"),
                                     selectedImage: UIImage(systemName: "message.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
