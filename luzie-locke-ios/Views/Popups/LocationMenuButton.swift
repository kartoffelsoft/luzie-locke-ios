//
//  LocationMenuButton.swift
//  luzie-locke-ios
//
//  Created by Harry on 14.11.21.
//

import UIKit

class LocationMenuButton: UIButton {
  
  var isMenuOpen: Bool? {
    didSet {
      if let isMenuOpen = isMenuOpen {
        setImage(isMenuOpen ? Images.chevronUp : Images.chevronDown, for: .normal)
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    setTitle("Kronberg", for: .normal)
    setTitleColor(Colors.primaryColor, for: .normal)
    titleLabel?.font          = Fonts.body
    titleLabel?.lineBreakMode = .byClipping
    imageEdgeInsets.left      = -5
    isMenuOpen                = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
