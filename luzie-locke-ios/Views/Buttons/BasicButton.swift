//
//  BasicButton.swift
//  luzie-locke-ios
//
//  Created by Harry on 17.10.21.
//

import UIKit

class BasicButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(backgroundColor: UIColor?, textColor: UIColor? = .white, title: String) {
    self.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
    self.setTitleColor(textColor, for: .normal)
  }
  
  private func configure() {
    layer.cornerRadius                          = 10
    titleLabel?.font                            = Fonts.subtitle
    translatesAutoresizingMaskIntoConstraints   = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

