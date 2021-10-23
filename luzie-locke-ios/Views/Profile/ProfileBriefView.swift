//
//  ProfileBriefView.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.10.21.
//

import UIKit

class ProfileBriefView: UIView {
  
  let avatarImageView = AvatarImageView(radius: 30)
  let userNameLabel   = KHeaderLabel(textAlignment: .left, fontSize: 18)
  let locationLabel   = KBodyLabel(textAlignment: .left)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    avatarImageView.layer.borderWidth = 3
    avatarImageView.layer.borderColor = UIColor(named: "PrimaryColorLight2")?.cgColor
    
    let userTexts = UIStackView(arrangedSubviews: [ userNameLabel, locationLabel ])
    userTexts.translatesAutoresizingMaskIntoConstraints = false
    userTexts.axis                                      = .vertical
    userTexts.distribution                              = .fillEqually
    
    let container = UIStackView(arrangedSubviews: [ avatarImageView, userTexts ])
    container.translatesAutoresizingMaskIntoConstraints = false
    container.axis                                      = .horizontal
    container.spacing                                   = 15

    addSubview(container)

    NSLayoutConstraint.activate([
      avatarImageView.widthAnchor.constraint(equalToConstant: 60),
      avatarImageView.heightAnchor.constraint(equalToConstant: 60),
      
      container.topAnchor.constraint(equalTo: topAnchor),
      container.bottomAnchor.constraint(equalTo: bottomAnchor),
      container.leadingAnchor.constraint(equalTo: leadingAnchor),
      container.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
