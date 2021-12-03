//
//  ItemActionPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

protocol ItemActionPanelViewDelegate: AnyObject {
  
  func didTapDeleteButton()
}

class ItemActionPanelView: UIView {
  
  weak var delegate: ItemActionPanelViewDelegate?
  
  let viewModel: ItemActionPanelViewModel
  
  private let buyerView   = UIView()
  private let sellerView  = UIView()
  
  private let buyerPriceLabel     = HeaderLabel(textColor: Colors.primaryColorLight3, textAlignment: .left)
  private let buyerChatButton     = BasicButton(backgroundColor: Colors.primaryColorLight3,
                                                textColor: Colors.primaryColor,
                                                title: "Chat")
  private let buyerFavoriteButton = RoundButton(radius: 30,
                                                image: Images.favoriteOff,
                                                backgroundColor: Colors.primaryColor)
  
  private let sellerPriceLabel    = HeaderLabel(textColor: Colors.secondaryColor,
                                                textAlignment: .left)
  private let sellerEditButton    = RoundButton(radius: 20,
                                                image: Images.itemEdit,
                                                backgroundColor: Colors.primaryColor)
  private let sellerDeleteButton  = RoundButton(radius: 20,
                                                image: Images.itemDelete,
                                                backgroundColor: Colors.primaryColor)

  init(viewModel: ItemActionPanelViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    
    configureLayout()
    configureBindables()
  }
  
  private func configureLayout() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor                           = Colors.primaryColor
    
    addSubview(buyerView)
    addSubview(sellerView)
    
    buyerView.pinToEdges(of: self)
    sellerView.pinToEdges(of: self)
    
    buyerView.addSubview(buyerFavoriteButton)
    buyerView.addSubview(buyerPriceLabel)
    buyerView.addSubview(buyerChatButton)

    sellerView.addSubview(sellerPriceLabel)
    sellerView.addSubview(sellerEditButton)
    sellerView.addSubview(sellerDeleteButton)
    
    self.buyerView.isHidden   = true
    self.sellerView.isHidden  = true
    
    let padding: CGFloat = 20
    NSLayoutConstraint.activate([
      buyerFavoriteButton.leadingAnchor.constraint(equalTo: buyerView.leadingAnchor, constant: padding),
      buyerFavoriteButton.centerYAnchor.constraint(equalTo: buyerView.centerYAnchor),

      buyerPriceLabel.leadingAnchor.constraint(equalTo: buyerFavoriteButton.trailingAnchor, constant: 10),
      buyerPriceLabel.centerYAnchor.constraint(equalTo: buyerView.centerYAnchor),
      buyerPriceLabel.heightAnchor.constraint(equalToConstant: 45),
      
      buyerChatButton.trailingAnchor.constraint(equalTo: buyerView.trailingAnchor, constant: -padding),
      buyerChatButton.centerYAnchor.constraint(equalTo: buyerView.centerYAnchor),
      buyerChatButton.heightAnchor.constraint(equalToConstant: 40),
      buyerChatButton.widthAnchor.constraint(equalToConstant: 65),
      
      sellerPriceLabel.leadingAnchor.constraint(equalTo: sellerView.leadingAnchor, constant: padding),
      sellerPriceLabel.centerYAnchor.constraint(equalTo: sellerView.centerYAnchor),
      sellerPriceLabel.heightAnchor.constraint(equalToConstant: 45),
      
      sellerDeleteButton.trailingAnchor.constraint(equalTo: sellerView.trailingAnchor, constant: -padding),
      sellerDeleteButton.centerYAnchor.constraint(equalTo: sellerView.centerYAnchor),
      sellerDeleteButton.heightAnchor.constraint(equalToConstant: 40),
      sellerDeleteButton.widthAnchor.constraint(equalToConstant: 40),
      
      sellerEditButton.trailingAnchor.constraint(equalTo: sellerDeleteButton.leadingAnchor, constant: -5),
      sellerEditButton.centerYAnchor.constraint(equalTo: sellerView.centerYAnchor),
      sellerEditButton.heightAnchor.constraint(equalToConstant: 40),
      sellerEditButton.widthAnchor.constraint(equalToConstant: 40),
    ])
    
    buyerFavoriteButton.addTarget(self, action: #selector(handleFavoriteButtonTap), for: .touchUpInside)
    buyerChatButton.addTarget(self, action: #selector(handleChatButtonTap), for: .touchUpInside)
    sellerEditButton.addTarget(self, action: #selector(handleEditButtonTap), for: .touchUpInside)
    sellerDeleteButton.addTarget(self, action: #selector(handleDeleteButtonTap), for: .touchUpInside)
  }
  
  @objc private func handleFavoriteButtonTap() {
    viewModel.didTapFavoriteButton()
  }
  
  @objc private func handleChatButtonTap() {
    viewModel.didTapChatButton()
  }
  
  @objc private func handleEditButtonTap() {
    viewModel.didTapEditButton()
  }
  
  @objc private func handleDeleteButtonTap() {
    delegate?.didTapDeleteButton()
  }

  private func configureBindables() {
    viewModel.bindablePriceText.bind { [weak self] text in
      self?.buyerPriceLabel.attributedText  = text
      self?.sellerPriceLabel.attributedText = text
    }
    
    viewModel.bindableIsMine.bind { [weak self] isMine in
      guard let self = self else { return }
      guard let isMine = isMine else { return }
      self.buyerView.isHidden   = isMine
      self.sellerView.isHidden  = !isMine
    }
    
    viewModel.bindableFavoriteOn.bind { [weak self] favoriteOn in
      guard let self = self else { return }
      guard let favoriteOn = favoriteOn else { return }
      DispatchQueue.main.async {
        self.buyerFavoriteButton.setImage(favoriteOn ? Images.favoriteOn : Images.favoriteOff, for: .normal)
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
