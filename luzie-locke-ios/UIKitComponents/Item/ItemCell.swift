//
//  ItemCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import UIKit

class ItemCell: UICollectionViewCell {
  
  static let reuseIdentifier = "ItemCell"

  var viewModel: ItemCellViewModel? {
    didSet {
      imageView.image           = viewModel?.bindableItemImage.value
      titleLabel.text           = viewModel?.bindableTitleText.value
      locationLabel.text        = viewModel?.bindableLocationText.value
      priceLabel.attributedText = makeAttributedPriceText(viewModel?.bindablePriceText.value)
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
        self?.priceLabel.attributedText = self?.makeAttributedPriceText(text)
      }
      
      viewModel?.bindableDateText.bind { [weak self] text in
        self?.dateLabel.text = text
      }
    }
  }
  
  let imageView     = ItemImageView()
  let titleLabel    = CustomLabel(font: CustomUIFonts.body, textColor: UIColor.custom.primaryColor)
  let locationLabel = CustomLabel(font: CustomUIFonts.caption, textColor: UIColor.custom.secondaryColor)
  let priceLabel    = CustomLabel(font: CustomUIFonts.body, textColor: UIColor.custom.primaryColor)
  let dateLabel     = CustomLabel(font: CustomUIFonts.detail, textColor: .gray)
  let line          = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
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
  
  private func makeAttributedPriceText(_ text: String?) -> NSAttributedString? {
    guard let text = text else { return nil }
    let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: CustomUIFonts.detail])
    priceText.append(NSAttributedString(string: text, attributes: [.font: CustomUIFonts.body]))
    return priceText
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
