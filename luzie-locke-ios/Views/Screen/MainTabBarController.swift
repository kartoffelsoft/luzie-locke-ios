//
//  ViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let userStorage:            UserStorage
    let loginCoordinator:       Coordinator
    
    let homeCoordinator:        HomeCoordinator
    let searchCoordinator:      SearchCoordinator
    let chatsCoordinator:       ChatsCoordinator
    let settingsCoordinator:    SettingsCoordinator
    
    init(userStorage: UserStorage, loginCoordinator: Coordinator) {
        self.userStorage            = userStorage
        self.loginCoordinator       = loginCoordinator
        self.homeCoordinator        = HomeCoordinator(navigationController: UINavigationController(), userStorage: userStorage)
        self.searchCoordinator      = SearchCoordinator(navigationController: UINavigationController(), userStorage: userStorage)
        self.chatsCoordinator       = ChatsCoordinator(navigationController: UINavigationController(), userStorage: userStorage)
        self.settingsCoordinator    = SettingsCoordinator(navigationController: UINavigationController(), userStorage: userStorage)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeCoordinator.start()
        searchCoordinator.start()
        chatsCoordinator.start()
        settingsCoordinator.start()
        
        view.backgroundColor    = .white
        tabBar.tintColor        = UIColor.label
        viewControllers         = [ homeCoordinator.navigationController,
                                    searchCoordinator.navigationController,
                                    chatsCoordinator.navigationController,
                                    settingsCoordinator.navigationController ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        if userStorage.available() == false {
            self.loginCoordinator.start()
            self.present(self.loginCoordinator.navigationController, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
