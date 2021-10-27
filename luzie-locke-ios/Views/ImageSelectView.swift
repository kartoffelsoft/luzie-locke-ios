//
//  File.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class ImageSelectView: UIView {
  
  lazy var image1Button = UIButton(type:.system)
  lazy var image2Button = UIButton(type:.system)
  lazy var image3Button = UIButton(type:.system)
  
  override init(frame: CGRect) {
      super.init(frame: frame)
      configure()
  }
  
  private func configure() {
    backgroundColor = .systemPink
//    image1Button.setTitle("Select Photo", for: .normal)
//    image1Button.backgroundColor = .white
//    image1Button.layer.cornerRadius = 8
//    image1Button.clipsToBounds = true
//
//    image2Button.setTitle("Locked", for: .normal)
//    image2Button.backgroundColor = .white
//    image2Button.layer.cornerRadius = 8
//    image2Button.clipsToBounds = true
//
//    image3Button.setTitle("Locked", for: .normal)
//    image3Button.backgroundColor = .white
//    image3Button.layer.cornerRadius = 8
//    image3Button.clipsToBounds = true
//
    
    
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
