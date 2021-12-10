//
//  ItemImageView.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.12.21.
//

import UIKit

class ItemImageView: UIImageView {

  private let placeholderImage = CustomUIImages.avatarPlaceholder
  
  init(cornerRadius: CGFloat = 10) {

    super.init(frame: .zero)
    
    layer.cornerRadius                        = cornerRadius
    image                                     = placeholderImage
    contentMode                               = .scaleAspectFill
    clipsToBounds                             = true
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
