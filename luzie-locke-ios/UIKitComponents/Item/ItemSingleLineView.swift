//
//  ItemSingleLineView.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.01.22.
//

import UIKit

class ItemSingleLineView: UIView {

  private let imageView = ItemImageView()
  private let stateLabel = CustomLabel(font: CustomUIFonts.body,
                                       textColor: CustomUIColors.tertiaryColor,
                                       textAlignment: .left)
  private let titleLabel = CustomLabel(font: CustomUIFonts.body,
                                       textColor: CustomUIColors.primaryColor,
                                       textAlignment: .left)
  
  var image: UIImage? {
    didSet {
      imageView.image = image
    }
  }
  
  var stateText: String? {
    didSet {
      stateLabel.text = stateText
      stateLabel.sizeToFit()
    }
  }
  
  var titleText: String? {
    didSet {
      titleLabel.text = titleText
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    titleLabel.numberOfLines = 1
    titleLabel.adjustsFontSizeToFitWidth = false
    titleLabel.lineBreakMode = .byTruncatingTail
    
    let textContainerView = UIStackView(arrangedSubviews: [ stateLabel, titleLabel ])
    textContainerView.axis = .vertical
    textContainerView.spacing = 5
    textContainerView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(imageView)
    addSubview(textContainerView)
    
    let padding: CGFloat = 10
    
    NSLayoutConstraint.activate([
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      imageView.widthAnchor.constraint(equalToConstant: 50),
      imageView.heightAnchor.constraint(equalToConstant: 50),
      
      textContainerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
      textContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      textContainerView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
