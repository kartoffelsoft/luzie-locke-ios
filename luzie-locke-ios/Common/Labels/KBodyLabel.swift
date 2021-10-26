//
//  KBodyLabel.swift
//  luzie-locke-ios
//
//  Created by Harry on 17.10.21.
//

import UIKit

class KBodyLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  convenience init(textAlignment: NSTextAlignment, textStyle: UIFont.TextStyle = .body) {
    self.init(frame: .zero)
    self.textAlignment = textAlignment
    self.font          = UIFont.preferredFont(forTextStyle: textStyle)
  }
  
  private func configure() {
    textColor                                   = .secondaryLabel
    font                                        = UIFont.preferredFont(forTextStyle: .body)
    adjustsFontForContentSizeCategory           = true
    adjustsFontSizeToFitWidth                   = true
    minimumScaleFactor                          = 0.75
    lineBreakMode                               = .byWordWrapping
    translatesAutoresizingMaskIntoConstraints   = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

