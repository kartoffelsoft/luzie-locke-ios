//
//  SettingsViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class SettingsViewController: UIViewController {

    var auth: Authable
    
    init(auth: Authable) {
        self.auth = auth
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Settings"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}