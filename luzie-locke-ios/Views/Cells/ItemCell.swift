//
//  ItemCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import UIKit

class ItemCell: UICollectionViewCell {
//  tmp
  let placeholderImage = Images.avatarPlaceholder
  
  static let reuseIdentifier = "ItemCell"

  let imageView     = UIImageView()
  let titleLabel    = KHeaderLabel(textAlignment: .left, textStyle: .subheadline)
  let locationLabel = KBodyLabel(textAlignment: .left, textStyle: .subheadline)
  let priceLabel    = KHeaderLabel(textAlignment: .left, textStyle: .headline)
  let line          = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    imageView.layer.cornerRadius                            = 10
    imageView.image                                         = placeholderImage
    imageView.contentMode                                   = .scaleAspectFill
    imageView.clipsToBounds                                 = true
    imageView.translatesAutoresizingMaskIntoConstraints     = false
    
    titleLabel.text                                         = "Hidsfdsgfdlkhdjgs;gldklksjgoie"
    titleLabel.numberOfLines                                = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints    = false
    
    locationLabel.text                                      = "Kronberg"
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    
    priceLabel.text                                         = "10"
    priceLabel.translatesAutoresizingMaskIntoConstraints    = false
    
    let stackView = UIStackView(arrangedSubviews: [ titleLabel, locationLabel, priceLabel ])
    stackView.axis                                          = .vertical
    stackView.spacing                                       = 5
    stackView.translatesAutoresizingMaskIntoConstraints     = false
    
    addSubview(imageView)
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 100),
      imageView.heightAnchor.constraint(equalToConstant: 100),
      
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
