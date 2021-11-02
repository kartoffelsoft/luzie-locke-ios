//
//  ProfileImageView.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.10.21.
//

import UIKit

class AvatarImageView: UIImageView {
  
  let radius: CGFloat
  let placeholderImage = Images.avatarPlaceholder
  
  init(radius: CGFloat) {
    self.radius = radius
    super.init(frame: .zero)
    
    configure()
  }

  private func configure() {
    layer.cornerRadius                        = radius
    image                                     = placeholderImage
    contentMode                               = .scaleAspectFill
    clipsToBounds                             = true
    translatesAutoresizingMaskIntoConstraints = false
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
