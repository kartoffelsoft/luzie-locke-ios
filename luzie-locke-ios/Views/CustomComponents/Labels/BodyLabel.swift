//
//  KBodyLabel.swift
//  luzie-locke-ios
//
//  Created by Harry on 17.10.21.
//

import UIKit

class BodyLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(font: UIFont = CustomUIFonts.title,
                   textColor: UIColor = .secondaryLabel,
                   textAlignment: NSTextAlignment = .left) {
    self.init(frame: .zero)
    self.font           = font
    self.textColor      = textColor
    self.textAlignment  = textAlignment
  }
  
  private func configure() {
    adjustsFontForContentSizeCategory           = true
    adjustsFontSizeToFitWidth                   = true
    minimumScaleFactor                          = 0.75
    lineBreakMode                               = .byWordWrapping
    translatesAutoresizingMaskIntoConstraints   = false
    numberOfLines                               = 0
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

