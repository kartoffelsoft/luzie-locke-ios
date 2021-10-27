//
//  ImageSelectButton.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class ImageSelectButton: UIButton {
  
  override var isEnabled: Bool {
    didSet {
      setImage(isEnabled ? Images.selectEnabled : Images.selectDisabled, for: .normal)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor                           = .white
    layer.cornerRadius                        = 8
    clipsToBounds                             = true
    adjustsImageWhenDisabled                  = true
    
    setImage(Images.selectEnabled , for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
