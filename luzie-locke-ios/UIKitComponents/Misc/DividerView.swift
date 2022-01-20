//
//  Divider.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.12.21.
//

import UIKit

class DividerView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.backgroundColor = UIColor.custom.primaryColorLight1.cgColor
  }
  
  override var intrinsicContentSize: CGSize {
      return .init(width: 0, height: 1)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
