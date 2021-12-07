//
//  NavigationHeaderLabel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import UIKit

class ScreenTitleLabel: UILabel {
  
  init(_ text: String) {
    super.init(frame: .zero)
    
    self.text = text
    textColor = CustomUIColors.primaryColor
    font      = UIFont(name: "Supercell-Magic", size: 15)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
