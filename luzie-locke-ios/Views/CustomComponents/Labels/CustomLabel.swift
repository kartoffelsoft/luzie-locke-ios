//
//  CustomLabel.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.11.21.
//

import UIKit

class CustomLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(font: UIFont = Fonts.body,
                   textColor: UIColor = .secondaryLabel) {
    self.init(frame: .zero)
    self.font           = font
    self.textColor      = textColor
  }
  
  private func configure() {
    adjustsFontForContentSizeCategory           = true
    adjustsFontSizeToFitWidth                   = true
    minimumScaleFactor                          = 0.75
    lineBreakMode                               = .byWordWrapping
    translatesAutoresizingMaskIntoConstraints   = false
    numberOfLines                               = 0
    textAlignment                               = .left
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

