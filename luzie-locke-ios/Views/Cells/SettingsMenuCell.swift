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
  let title  = HeaderLabel(font: Fonts.body, textAlignment: .left)
  let arrow  = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    symbol.translatesAutoresizingMaskIntoConstraints  = false
    title.translatesAutoresizingMaskIntoConstraints   = false
    arrow.translatesAutoresizingMaskIntoConstraints   = false
    
    arrow.image = Images.menuItemArrow
    
    addSubview(symbol)
    addSubview(title)
    addSubview(arrow)
    
    let padding: CGFloat = 15
    NSLayoutConstraint.activate([
      symbol.centerYAnchor.constraint(equalTo: centerYAnchor),
      symbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      symbol.widthAnchor.constraint(equalToConstant: 25),
      symbol.heightAnchor.constraint(equalToConstant: 25),
      
      arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
      arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      arrow.widthAnchor.constraint(equalToConstant: 10),
      arrow.heightAnchor.constraint(equalToConstant: 15),
      
      title.centerYAnchor.constraint(equalTo: centerYAnchor),
      title.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: padding),
      title.trailingAnchor.constraint(equalTo: arrow.leadingAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

