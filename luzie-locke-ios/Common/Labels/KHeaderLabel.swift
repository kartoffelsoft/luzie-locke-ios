//
//  KHeaderLabel.swift
//  luzie-locke-ios
//
//  Created by Harry on 17.10.21.
//

import UIKit

class KHeaderLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(textAlignment: NSTextAlignment, textStyle: UIFont.TextStyle = .headline) {
    self.init(frame: .zero)
    self.textAlignment  = textAlignment
    self.font           = UIFont.preferredFont(forTextStyle: textStyle)
  }
  
  private func configure() {
    textColor                                   = .label
    font                                        = UIFont.preferredFont(forTextStyle: .headline)
    adjustsFontSizeToFitWidth                   = true
    minimumScaleFactor                          = 0.9
    lineBreakMode                               = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints   = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
