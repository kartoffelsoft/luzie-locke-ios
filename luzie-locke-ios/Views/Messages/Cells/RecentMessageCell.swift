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
      userImageView.image = viewModel?.bindableImage.value
      userNameLabel.text  = viewModel?.bindableNameText.value
      messageLabel.text   = viewModel?.bindableMessageText.value
      dateLabel.text      = viewModel?.bindableDateText.value

      viewModel?.bindableImage.bind { [weak self] image in
        self?.userImageView.image = image
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
  
  let userImageView = AvatarImageView(radius: 30)
  let userNameLabel = HeaderLabel(font: CustomUIFonts.caption, textAlignment: .left)
  let messageLabel  = BodyLabel(font: CustomUIFonts.detail, textAlignment: .left)
  let dateLabel     = HeaderLabel(font: CustomUIFonts.detail, textColor: .tertiaryLabel, textAlignment: .left)
  let line          = UIView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  
  fileprivate func configure() {
    backgroundColor = CustomUIColors.primaryColorLight2.withAlphaComponent(0.1)
    
    userImageView.layer.borderWidth = 3
    userImageView.layer.borderColor = UIColor(named: "PrimaryColorLight2")?.cgColor

    let stackView     = UIStackView(arrangedSubviews: [userNameLabel, messageLabel])
    stackView.axis    = .vertical
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(userImageView)
    addSubview(stackView)
    addSubview(dateLabel)
    
    let padding: CGFloat = 10
    NSLayoutConstraint.activate([
      userImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      userImageView.widthAnchor.constraint(equalToConstant: 60),
      userImageView.heightAnchor.constraint(equalToConstant: 60),
      
      stackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 15),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      stackView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),

      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      dateLabel.bottomAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
