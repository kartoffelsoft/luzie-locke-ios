//
//  SoldOutView.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import UIKit

class SoldOutView: UIView {
  
  private let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = CustomUIColors.primaryColor.withAlphaComponent(0.5)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = CustomUIImages.soldOut

    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
