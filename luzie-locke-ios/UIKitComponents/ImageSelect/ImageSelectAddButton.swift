//
//  ImageSelectAddButton.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.12.21.
//

import UIKit

class ImageSelectAddButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor                           = CustomUIColors.primaryColorLight2.withAlphaComponent(0.2)
    clipsToBounds                             = true
    adjustsImageWhenDisabled                  = true
    setImage(Images.imageAdd , for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
