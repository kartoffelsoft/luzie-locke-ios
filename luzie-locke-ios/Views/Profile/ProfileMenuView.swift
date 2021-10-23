//
//  ProfileMenuView.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.10.21.
//

import UIKit

class ProfileMenuView: UIView {
  
  let listings  = ProfileMenuItemView(image: Images.listings, text: "Listings")
  let purchases = ProfileMenuItemView(image: Images.purchases, text: "Purchaces")
  let favorites = ProfileMenuItemView(image: Images.favorites, text: "Favorites")
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    let container           = UIStackView(arrangedSubviews: [ listings, purchases, favorites ])
    container.axis          = .horizontal
    container.distribution  = .fillEqually
    
    addSubview(container)
    container.pinToEdges(of: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
