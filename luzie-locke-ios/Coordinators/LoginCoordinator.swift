//
//  LoginCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class LoginCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    var auth: Authable
    
    init(navigationController: UINavigationController, auth: Authable) {
        self.navigationController = navigationController
        self.auth = auth
        
        self.navigationController.modalPresentationStyle = .fullScreen
    }
    
    func start() {
        let vc = LoginViewController(auth: auth)
        navigationController.pushViewController(vc, animated: false)
    }
}
