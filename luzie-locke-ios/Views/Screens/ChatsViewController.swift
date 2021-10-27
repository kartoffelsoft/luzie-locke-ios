//
//  ChatViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class ChatsViewController: UIViewController {
  
  var profileStorage: AnyStorage<User>
  
  init(profileStorage: AnyStorage<User>) {
    self.profileStorage = profileStorage
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Chat"))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
