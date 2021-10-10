//
//  ViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class MainViewController: UITabBarController {

    var authManager: AuthManager?
    
    init(authManager: AuthManager?) {
        self.authManager = authManager
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor    = .white
        tabBar.tintColor        = UIColor.label
        viewControllers         = [ createHomeViewController(),
                                    createSearchViewController(),
                                    createChatViewController(),
                                    createSettingsViewController() ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        if authManager?.isLoggedIn() == false {
            let vc = LoginViewController()
//            vc.delegate = self
            
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            
            present(nc, animated: true)
        }
    }
    
    func createHomeViewController() -> UINavigationController {
        let vc          = HomeViewController()
        vc.tabBarItem   = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house.circle"),
                                       selectedImage: UIImage(systemName: "house.circle.fill"))
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createSearchViewController() -> UINavigationController {
        let vc          = SearchViewController()
        vc.tabBarItem   = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass.circle"),
                                       selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createSettingsViewController() -> UINavigationController {
        let vc          = SettingsViewController()
        vc.tabBarItem   = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "person.crop.circle"),
                                       selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createChatViewController() -> UINavigationController {
        let vc          = ChatViewController()
        vc.tabBarItem   = UITabBarItem(title: "Chat",
                                       image: UIImage(systemName: "message.circle"),
                                       selectedImage: UIImage(systemName: "message.circle.fill"))
        
        return UINavigationController(rootViewController: vc)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

