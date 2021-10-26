//
//  ProfileCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 21.10.21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
  
  static let reuseIdentifier = "ProfileCell"

  let userImageView     = AvatarImageView(radius: 30)
  let userNameLabel     = KHeaderLabel(textAlignment: .left)
  let userLocationLabel = KBodyLabel(textAlignment: .left, textStyle: .subheadline)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    userImageView.layer.borderWidth = 3
    userImageView.layer.borderColor = UIColor(named: "PrimaryColorLight2")?.cgColor

    addSubview(userImageView)
    addSubview(userNameLabel)
    addSubview(userLocationLabel)
    
    NSLayoutConstraint.activate([
      userImageView.topAnchor.constraint(equalTo: topAnchor),
      userImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      userImageView.widthAnchor.constraint(equalToConstant: 60),
      userImageView.heightAnchor.constraint(equalToConstant: 60),
      
      userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 15),
      userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      userNameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: -12),
      
      userLocationLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 15),
      userLocationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      userLocationLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: 12),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
