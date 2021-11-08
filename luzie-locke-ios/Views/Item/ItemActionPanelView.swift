//
//  ItemActionPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemActionPanelView: UIView {
  
  let viewModel: ItemActionPanelViewModel
  
  private let priceLabel  = HeaderLabel(textColor: Colors.primaryColorLight3, textAlignment: .left)
  private let chatButton  = KBasicButton(backgroundColor: Colors.primaryColorLight3,
                                         textColor: Colors.primaryColor,
                                         title: "Chat")
  
  private let favoriteButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(Images.favoriteOff, for: .normal)
    return button
  }()
  
  init(viewModel: ItemActionPanelViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    
    configureLayout()
    configureBindables()
  }
  
  private func configureLayout() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor                           = Colors.primaryColor

    addSubview(favoriteButton)
    addSubview(priceLabel)
    addSubview(chatButton)
    
    let padding: CGFloat = 20
    NSLayoutConstraint.activate([
      favoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),

      priceLabel.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 10),
      priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      priceLabel.heightAnchor.constraint(equalToConstant: 45),
      priceLabel.widthAnchor.constraint(equalToConstant: 65),
      
      chatButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      chatButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      chatButton.heightAnchor.constraint(equalToConstant: 40),
      chatButton.widthAnchor.constraint(equalToConstant: 65)
    ])
    
    favoriteButton.addTarget(self, action: #selector(handleFavoriteButtonTap), for: .touchUpInside)
    chatButton.addTarget(self, action: #selector(handleChatButtonTap), for: .touchUpInside)
  }
  
  @objc private func handleFavoriteButtonTap() {
    viewModel.didTapFavoriteButton()
  }
  
  @objc private func handleChatButtonTap() {
    viewModel.didTapChatButton()
  }

  private func configureBindables() {
    viewModel.bindablePriceText.bind { [weak self] text in
      self?.priceLabel.attributedText = text
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
