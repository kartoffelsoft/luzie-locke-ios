//
//  ProfileCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 21.10.21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
  
  static let reuseIdentifier = "ProfileCell"
  
  var profile:        Profile?
  var openHttpClient: OpenHTTPClient?

  private let profileBriefView = ProfileBriefView(frame: .zero)
  
  func load() {
    guard let profile = profile else { return }
    profileBriefView.userNameLabel.text  = profile.name
    profileBriefView.locationLabel.text  = profile.location.name
          
    guard let openHttpClient = openHttpClient else { return }
    openHttpClient.downloadImage(from: profile.pictureURI) { [weak self] result in
      switch result {
      case .success(let image):
        DispatchQueue.main.async { self?.profileBriefView.avatarImageView.image = image }
      case .failure:
        ()
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    addSubview(profileBriefView)
    
    let padding: CGFloat = 10
    NSLayoutConstraint.activate([
      profileBriefView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      profileBriefView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      profileBriefView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      profileBriefView.heightAnchor.constraint(equalToConstant: 60),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
