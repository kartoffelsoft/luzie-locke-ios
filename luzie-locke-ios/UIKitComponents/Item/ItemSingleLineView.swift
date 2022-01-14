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
                                       textColor: CustomUIColors.primaryColor,
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
    
    addSubview(imageView)
    addSubview(stateLabel)
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      imageView.widthAnchor.constraint(equalToConstant: 50),
      imageView.heightAnchor.constraint(equalToConstant: 50),
      
      stateLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      stateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
      
      titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: 5),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
