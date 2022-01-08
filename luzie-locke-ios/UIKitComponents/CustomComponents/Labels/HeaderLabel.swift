//
//  HeaderLabel.swift
//  luzie-locke-ios
//
//  Created by Harry on 17.10.21.
//

import UIKit

class HeaderLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(font: UIFont = CustomUIFonts.title,
                   textColor: UIColor = CustomUIColors.primaryColor,
                   textAlignment: NSTextAlignment = .left) {
    self.init(frame: .zero)
    self.font           = font
    self.textColor      = textColor
    self.textAlignment  = textAlignment
  }
  
  private func configure() {
    adjustsFontSizeToFitWidth                   = true
    minimumScaleFactor                          = 0.9
    lineBreakMode                               = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints   = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
