//
//  ProfileMenuItemView.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.10.21.
//

import UIKit

class ProfileMenuItemView: UIView {
  
  let symbol = UIImageView()
  let title  = KHeaderLabel(textAlignment: .center, fontSize: 12, weight: .regular)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    symbol.contentMode  = .scaleAspectFill
    configure()
  }
  
  convenience init(image: UIImage?, text: String) {
    self.init(frame: .zero)
    symbol.image = image
    title.text   = text
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints         = false
    symbol.translatesAutoresizingMaskIntoConstraints  = false
    title.translatesAutoresizingMaskIntoConstraints   = false
    
    symbol.tintColor = .darkGray
    
    let container = UIStackView(arrangedSubviews: [symbol, title])
    container.axis      = .vertical
    container.alignment = .center
    container.spacing   = 5
    
    addSubview(container)
    container.pinToEdges(of: self)
    
    container.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      symbol.widthAnchor.constraint(equalToConstant: 60),
      symbol.heightAnchor.constraint(equalToConstant: 60),
      
      container.topAnchor.constraint(equalTo: topAnchor),
      container.leadingAnchor.constraint(equalTo: leadingAnchor),
      container.trailingAnchor.constraint(equalTo: trailingAnchor),
      container.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
