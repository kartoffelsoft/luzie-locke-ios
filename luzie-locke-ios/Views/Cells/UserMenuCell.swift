//
//  UserMenuCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.10.21.
//

import UIKit

struct UserMenuItem {
  var image:  UIImage?
  var text:   String
}

class UserMenuCell: UICollectionViewCell {
  
  static let reuseIdentifier = "ProfileMenuCell"
  
  var item: UserMenuItem? {
    didSet {
      symbol.image  = item?.image
      title.text    = item?.text
    }
  }
  
  private let symbol = UIImageView()
  private let title  = HeaderLabel(font: CustomUIFonts.caption, textAlignment: .center)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    symbol.translatesAutoresizingMaskIntoConstraints  = false
    title.translatesAutoresizingMaskIntoConstraints   = false
    
    symbol.tintColor = .darkGray
    
    addSubview(symbol)
    addSubview(title)
    
    NSLayoutConstraint.activate([
      symbol.topAnchor.constraint(equalTo: topAnchor),
      symbol.centerXAnchor.constraint(equalTo: centerXAnchor),
      symbol.widthAnchor.constraint(equalToConstant: 60),
      symbol.heightAnchor.constraint(equalToConstant: 60),
      
      title.topAnchor.constraint(equalTo: symbol.bottomAnchor, constant: 5),
      title.centerXAnchor.constraint(equalTo: symbol.centerXAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
