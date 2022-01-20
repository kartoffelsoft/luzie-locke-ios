//
//  LocationMenuPopoverController.swift
//  luzie-locke-ios
//
//  Created by Harry on 14.11.21.
//

import UIKit

class LocationMenuViewController: UIViewController {
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.custom.primaryColorLight3.withAlphaComponent(0.2)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
