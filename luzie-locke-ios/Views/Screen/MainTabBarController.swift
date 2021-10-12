//
//  ViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let auth:                   Authable
    let loginCoordinator:       Coordinator
    
    let homeCoordinator:        HomeCoordinator
    let searchCoordinator:      SearchCoordinator
    let chatsCoordinator:       ChatsCoordinator
    let settingsCoordinator:    SettingsCoordinator
    
    init(auth: Authable, loginCoordinator: Coordinator) {
        self.auth                   = auth
        self.loginCoordinator       = loginCoordinator
        self.homeCoordinator        = HomeCoordinator(navigationController: UINavigationController(), auth: auth)
        self.searchCoordinator      = SearchCoordinator(navigationController: UINavigationController(), auth: auth)
        self.chatsCoordinator       = ChatsCoordinator(navigationController: UINavigationController(), auth: auth)
        self.settingsCoordinator    = SettingsCoordinator(navigationController: UINavigationController(), auth: auth)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        print("ViewDidLoad")
        super.viewDidLoad()
        
        view.backgroundColor    = .white
        tabBar.tintColor        = UIColor.label

        homeCoordinator.start()
        searchCoordinator.start()
        chatsCoordinator.start()
        settingsCoordinator.start()
        
        viewControllers         = [ homeCoordinator.navigationController,
                                    searchCoordinator.navigationController,
                                    chatsCoordinator.navigationController,
                                    settingsCoordinator.navigationController ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        if auth.isAuthencated() == false {
            self.loginCoordinator.start()
            self.present(self.loginCoordinator.navigationController, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
