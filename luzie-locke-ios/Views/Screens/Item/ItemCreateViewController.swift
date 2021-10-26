//
//  ItemCreateViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 26.10.21.
//

import UIKit

class ItemCreateViewController: UIViewController {
  
  lazy var image1Button = createButton(selector: #selector(handleSelectPhoto))
  lazy var image2Button = createButton(selector: #selector(handleSelectPhoto))
  lazy var image3Button = createButton(selector: #selector(handleSelectPhoto))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    // Do any additional setup after loading the view.
  }
  
  func createButton(selector: Selector) -> UIButton {
      let button = UIButton(type:.system)
      button.setTitle("Select Photo", for: .normal)
      button.backgroundColor = .white
      button.layer.cornerRadius = 8
      button.clipsToBounds = true
      button.addTarget(self, action: selector, for: .touchUpInside)

      return button
  }
  
  @objc private func handleSelectPhoto() {
    
  }
}
