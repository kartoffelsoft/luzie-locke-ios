//
//  SettingsMenuCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.10.21.
//

import UIKit

struct SettingsMenuItem {
  var image:  UIImage?
  var text:   String
}

class SettingsMenuCell: UICollectionViewCell {
  
  static let reuseIdentifier = "SettingsMenuCell"
  
  var item: SettingsMenuItem? {
    didSet {
      symbol.image  = item?.image
      title.text    = item?.text
    }
  }
  
  let symbol = UIImageView()
  let title  = HeaderLabel(textAlignment: .left, font: Fonts.body)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    symbol.tintColor = .black
    
    symbol.translatesAutoresizingMaskIntoConstraints  = false
    title.translatesAutoresizingMaskIntoConstraints   = false
    
    addSubview(symbol)
    addSubview(title)
    
    let padding: CGFloat = 15
    NSLayoutConstraint.activate([
      symbol.centerYAnchor.constraint(equalTo: centerYAnchor),
      symbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      symbol.widthAnchor.constraint(equalToConstant: 25),
      symbol.heightAnchor.constraint(equalToConstant: 25),
      
      title.centerYAnchor.constraint(equalTo: centerYAnchor),
      title.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: padding),
      title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

