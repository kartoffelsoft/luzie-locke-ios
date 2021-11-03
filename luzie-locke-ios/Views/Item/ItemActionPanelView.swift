//
//  ItemActionPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemActionPanelView: UIView {
  
  let vm: ItemActionPanelViewModel
  
  let priceLabel          = HeaderLabel(textColor: Colors.primaryColorLight3, textAlignment: .left)
  
  private let chatButton  = KBasicButton(backgroundColor: Colors.primaryColorLight3,
                                         textColor: Colors.primaryColor,
                                         title: "Chat")
  
  init(vm: ItemActionPanelViewModel) {
    self.vm = vm
    super.init(frame: .zero)
    
    configureLayout()
    configureBindables()
  }
  
  private func configureLayout() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor                           = Colors.primaryColor
    
    let favoriteImage = UIImageView(image: Images.favoriteOff)
    favoriteImage.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(favoriteImage)
    addSubview(priceLabel)
    addSubview(chatButton)
    
    let padding: CGFloat = 20
    NSLayoutConstraint.activate([
      favoriteImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      favoriteImage.centerYAnchor.constraint(equalTo: centerYAnchor),

      priceLabel.leadingAnchor.constraint(equalTo: favoriteImage.trailingAnchor, constant: 10),
      priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      priceLabel.heightAnchor.constraint(equalToConstant: 45),
      priceLabel.widthAnchor.constraint(equalToConstant: 65),
      
      chatButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      chatButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      chatButton.heightAnchor.constraint(equalToConstant: 40),
      chatButton.widthAnchor.constraint(equalToConstant: 65)
    ])
  }
  
  private func configureBindables() {
    vm.bindablePriceText.bind { [weak self] text in
      self?.priceLabel.attributedText = text
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
