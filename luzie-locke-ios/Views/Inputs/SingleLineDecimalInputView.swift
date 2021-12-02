//
//  SingleLineDecimalInputView.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.12.21.
//

import UIKit

class SingleLineDecimalInputView: UIView {
  
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
  
  var viewModel: SingleLineDecimalInputViewModel?
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
    textField.keyboardType    = UIKeyboardType.decimalPad
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

extension SingleLineDecimalInputView: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return viewModel?.isNextStringOkay(string) ?? false
  }
  
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
