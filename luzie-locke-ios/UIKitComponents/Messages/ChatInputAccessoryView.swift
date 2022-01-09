//
//  ChatInputPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.11.21.
//

import UIKit

class ChatInputAccessoryView: UIView {
  
  let textField: UITextField = {
    let field          = UITextField()
    field.placeholder  = "Enter message"
    field.font         = CustomUIFonts.body
    field.textColor    = CustomUIColors.primaryColorLight3
    field.attributedPlaceholder = NSAttributedString(
      string: "Enter message",
      attributes: [NSAttributedString.Key.foregroundColor: CustomUIColors.secondaryColor]
    )
    return field
  }()
  
  let sendButton: UIButton = {
    let button = UIButton()
    button.setImage(Images.messageSend, for: .normal)
    button.heightAnchor.constraint(equalToConstant: 60).isActive = true
    button.widthAnchor.constraint(equalToConstant: 60).isActive = true
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  override var intrinsicContentSize: CGSize {
    return .init(width: frame.width, height: 60)
  }

  private func configure() {
    backgroundColor     = CustomUIColors.primaryColor
    layer.shadowOpacity = 0.1
    layer.shadowRadius  = 8
    layer.shadowOffset  = .init(width: 0, height: -8)
    layer.shadowColor   = UIColor.init(white: 0, alpha: 0.3).cgColor
    autoresizingMask    = .flexibleHeight
    
    let stack           = UIStackView(arrangedSubviews: [ textField, sendButton ])
    stack.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 8)
    stack.alignment     = .center
    stack.isLayoutMarginsRelativeArrangement = true
    
    addSubview(stack)
    stack.pinToEdges(of: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
