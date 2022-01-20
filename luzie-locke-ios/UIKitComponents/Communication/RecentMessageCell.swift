//
//  InboxCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import UIKit

class RecentMessageCell: UITableViewCell {
  
  static let reuseIdentifier = "RecentMessageCell"
  
  var viewModel: RecentMessageCellViewModel? {
    didSet {
      itemImageView.image = viewModel?.bindableItemImage.value
      userImageView.image = viewModel?.bindableUserImage.value
      userNameLabel.text  = viewModel?.bindableNameText.value
      messageLabel.text   = viewModel?.bindableMessageText.value
      dateLabel.text      = viewModel?.bindableDateText.value

      viewModel?.bindableItemImage.bind { [weak self] image in
        DispatchQueue.main.async {
          self?.itemImageView.image = image
        }
      }
      
      viewModel?.bindableUserImage.bind { [weak self] image in
        DispatchQueue.main.async {
          self?.userImageView.image = image
        }
      }
      
      viewModel?.bindableNameText.bind { [weak self] text in
        self?.userNameLabel.text = text
      }
      
      viewModel?.bindableMessageText.bind { [weak self] text in
        self?.messageLabel.text = text
      }
      
      viewModel?.bindableDateText.bind { [weak self] text in
        self?.dateLabel.text = text
      }
    }
  }
  
  let itemImageView = ItemImageView()
  let userImageView = AvatarImageView(radius: 20)
  let userNameLabel = HeaderLabel(font: CustomUIFonts.caption, textAlignment: .left)
  let messageLabel  = BodyLabel(font: CustomUIFonts.detail, textAlignment: .left)
  let dateLabel     = HeaderLabel(font: CustomUIFonts.detail, textColor: .tertiaryLabel, textAlignment: .left)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  
  fileprivate func configure() {
    backgroundColor = UIColor.custom.primaryColorLight2.withAlphaComponent(0.1)
    
    userImageView.layer.borderWidth = 2
    userImageView.layer.borderColor = UIColor.custom.secondaryColor.cgColor
    userImageView.layer.backgroundColor = UIColor.custom.primaryColorLight3.cgColor

    let stackView     = UIStackView(arrangedSubviews: [userNameLabel, messageLabel])
    stackView.axis    = .vertical
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(itemImageView)
    addSubview(userImageView)
    addSubview(stackView)
    addSubview(dateLabel)
    
    let padding: CGFloat = 10
    NSLayoutConstraint.activate([
      itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      itemImageView.widthAnchor.constraint(equalToConstant: 60),
      itemImageView.heightAnchor.constraint(equalToConstant: 60),
      
      userImageView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: -15),
      userImageView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor,constant: 5),
      userImageView.widthAnchor.constraint(equalToConstant: 40),
      userImageView.heightAnchor.constraint(equalToConstant: 40),
      
      stackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      stackView.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor),

      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      dateLabel.bottomAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
