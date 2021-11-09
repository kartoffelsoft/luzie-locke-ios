//
//  ChatViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class CommunicationViewController: UIViewController {
  
  var profileStorage: AnyStorage<User>
  
  init(profileStorage: AnyStorage<User>) {
    self.profileStorage = profileStorage
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Chat"))
    configureGradientBackground()
  }
  
  func configureGradientBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
