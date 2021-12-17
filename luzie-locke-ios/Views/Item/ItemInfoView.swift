//
//  ItemInfoView.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.11.21.
//

import UIKit

class ItemInfoView: UIView {

  let titleLabel        = CustomLabel(font: CustomUIFonts.subtitle,
                                      textColor: CustomUIColors.primaryColor,
                                      textAlignment: .left)
  
  let descriptionLabel  = CustomLabel(font: CustomUIFonts.body,
                                      textColor: .secondaryLabel,
                                      textAlignment: .left)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis                                      = .vertical
    stackView.spacing                                   = 12
    
    addSubview(stackView)
    
    stackView.pinToEdges(of: self, insets: .init(top: 10, left: 10, bottom: 10, right: 10))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
