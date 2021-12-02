//
//  SingleLineTextInputView.swift
//  luzie-locke-ios
//
//  Created by Harry on 30.11.21.
//

import UIKit

class SingleLineTextInputView: UIView {
  
  class CustomTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 12, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 12, dy: 0)
    }
  }

  private let textField         = CustomTextField()
  private let placeholderColor  = Colors.primaryColorLight1
  
  var viewModel: SingleLineTextInputViewModel?
  var placeholder: String? {
    didSet {
      textField.text      = placeholder
      textField.textColor = placeholderColor
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints           = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(textField)
    textField.pinToEdges(of: self)
    
    textField.delegate        = self
    textField.font            = Fonts.body
    textField.backgroundColor = .clear
    
    textField.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
  }
  
  @objc private func handleInputChange(textField: UITextField) {
    viewModel?.text = textField.text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SingleLineTextInputView: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.textColor == placeholderColor && textField.isFirstResponder {
      textField.text      = nil
      textField.textColor = Colors.primaryColor
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text, text.isEmpty || text == "" {
      textField.text      = placeholder
      textField.textColor = placeholderColor
    }
  }
}
