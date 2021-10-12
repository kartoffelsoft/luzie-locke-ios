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
    
    var auth: Authable
    
    init(navigationController: UINavigationController, auth: Authable) {
        self.navigationController = navigationController
        self.auth = auth
    }
    
    func start() {
        let vc = ChatsViewController(auth: auth)
        vc.tabBarItem = UITabBarItem(title: "Chat",
                                     image: UIImage(systemName: "message.circle"),
                                     selectedImage: UIImage(systemName: "message.circle.fill"))
        
        navigationController.pushViewController(vc, animated: false)
    }
}
