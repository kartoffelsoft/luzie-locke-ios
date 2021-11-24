//
//  EmptyStateView.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.11.21.
//

import UIKit

class EmptyStateView: UIView {
  
  let messageLabel = HeaderLabel(textAlignment: .center)
  let logoImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(message: String) {
    self.init(frame: .zero)
    messageLabel.text = message
  }
  
  private func configure() {
    addSubview(logoImageView)
    addSubview(messageLabel)
    
    messageLabel.numberOfLines = 3
    messageLabel.textColor = .secondaryLabel
    
//    logoImageView.image = Images.mainLogo
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
      logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
      logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
      logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),
      
      messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -75),
      messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      messageLabel.heightAnchor.constraint(equalToConstant: 200),
    ])
  }
  
}
