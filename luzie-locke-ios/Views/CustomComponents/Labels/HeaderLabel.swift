//
//  KHeaderLabel.swift
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
  
  convenience init(textAlignment: NSTextAlignment, font: UIFont = Fonts.title, textColor: UIColor = Colors.primaryColor) {
    self.init(frame: .zero)
    self.textAlignment  = textAlignment
    self.font           = font
    self.textColor      = textColor
  }
  
  private func configure() {
    textColor                                   = Colors.primaryColor
    adjustsFontSizeToFitWidth                   = true
    minimumScaleFactor                          = 0.9
    lineBreakMode                               = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints   = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
