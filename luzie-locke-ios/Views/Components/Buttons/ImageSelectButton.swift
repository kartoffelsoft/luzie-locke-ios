//
//  ImageSelectButton.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class ImageSelectButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor                           = .systemBackground
    layer.cornerRadius                        = 8
    layer.borderWidth                         = 1
    layer.borderColor                         = UIColor(named: "PrimaryColor")?.cgColor
    layer.cornerRadius                        = 5
    
    clipsToBounds                             = true
    adjustsImageWhenDisabled                  = true
    
    setImage(Images.selectImage , for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
