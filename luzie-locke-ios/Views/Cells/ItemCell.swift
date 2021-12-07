//
//  ItemCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import UIKit

class ItemCell: UICollectionViewCell {

  let placeholderImage = Images.avatarPlaceholder
  
  static let reuseIdentifier = "ItemCell"

  var viewModel: ItemCellViewModel? {
    didSet {
      imageView.image           = viewModel?.bindableItemImage.value
      titleLabel.text           = viewModel?.bindableTitleText.value
      locationLabel.text        = viewModel?.bindableLocationText.value
      priceLabel.attributedText = viewModel?.bindablePriceText.value
      dateLabel.text            = viewModel?.bindableDateText.value
      
      viewModel?.bindableItemImage.bind { [weak self] image in
        self?.imageView.image = image
      }
      
      viewModel?.bindableTitleText.bind { [weak self] text in
        self?.titleLabel.text = text
      }
      
      viewModel?.bindableLocationText.bind { [weak self] text in
        self?.locationLabel.text = text
      }
      
      viewModel?.bindablePriceText.bind { [weak self] text in
        self?.priceLabel.attributedText = text
      }
      
      viewModel?.bindableDateText.bind { [weak self] text in
        self?.dateLabel.text = text
      }
    }
  }
  
  let imageView     = UIImageView()
  let titleLabel    = CustomLabel(font: CustomUIFonts.body, textColor: CustomUIColors.primaryColor)
  let locationLabel = CustomLabel(font: CustomUIFonts.caption, textColor: CustomUIColors.secondaryColor)
  let priceLabel    = CustomLabel(font: CustomUIFonts.body, textColor: CustomUIColors.primaryColor)
  let dateLabel     = CustomLabel(font: CustomUIFonts.detail, textColor: .gray)
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
    
    titleLabel.numberOfLines                                = 0
    
    let stackView = UIStackView(arrangedSubviews: [ titleLabel, locationLabel, priceLabel ])
    stackView.axis                                          = .vertical
    stackView.spacing                                       = 5
    stackView.translatesAutoresizingMaskIntoConstraints     = false
    
    addSubview(imageView)
    addSubview(stackView)
    addSubview(dateLabel)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 100),
      imageView.heightAnchor.constraint(equalToConstant: 100),
      
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
