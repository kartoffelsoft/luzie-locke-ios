//
//  RoundButton.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.11.21.
//

import UIKit

class RoundButton: UIButton {
  
  private let radius: CGFloat
  
  init(radius: CGFloat = 20, image: UIImage? = nil,  backgroundColor: UIColor = .white) {
    self.radius = radius
    super.init(frame: .zero)
    self.setImage(image, for: .normal)
    self.backgroundColor = backgroundColor

    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = radius
  }
  
  override var intrinsicContentSize: CGSize {
    var size    = super.intrinsicContentSize
    size.height = radius * 2
    size.width  = radius * 2
    return size
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

