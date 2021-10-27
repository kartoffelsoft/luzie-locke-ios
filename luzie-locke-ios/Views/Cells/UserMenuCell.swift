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
  
  let symbol = UIImageView()
  let title  = KHeaderLabel(textAlignment: .center, textStyle: .subheadline)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    symbol.translatesAutoresizingMaskIntoConstraints  = false
    title.translatesAutoresizingMaskIntoConstraints   = false
    
    symbol.tintColor = .darkGray
    
//    let container = UIStackView(arrangedSubviews: [symbol, title])
//    container.axis      = .vertical
//    container.alignment = .center
//    container.spacing   = 5
    
//    addSubview(container)
//    container.pinToEdges(of: self)
//
//    container.translatesAutoresizingMaskIntoConstraints = false
    
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