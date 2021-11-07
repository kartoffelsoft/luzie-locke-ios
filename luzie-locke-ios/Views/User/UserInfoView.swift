//
//  UserInfoView.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.11.21.
//

import UIKit

class UserInfoView: UIView {

  let imageView     = AvatarImageView(radius: 30)
  let nameLabel     = HeaderLabel(textAlignment: .left)
  let locationLabel = BodyLabel(font: Fonts.caption, textAlignment: .left)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    imageView.layer.borderWidth = 3
    imageView.layer.borderColor = UIColor(named: "PrimaryColorLight2")?.cgColor

    addSubview(imageView)
    addSubview(nameLabel)
    addSubview(locationLabel)
    
    let padding: CGFloat = 10
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      imageView.widthAnchor.constraint(equalToConstant: 60),
      imageView.heightAnchor.constraint(equalToConstant: 60),
      
      nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -12),
      
      locationLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
      locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      locationLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 12),
    ])
  }
}
