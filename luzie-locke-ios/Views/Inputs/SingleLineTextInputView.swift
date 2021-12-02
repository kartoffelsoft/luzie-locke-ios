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
  
  var viewModel: InputViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      
      textField.text = viewModel.bindableText.value
      textField.textColor = viewModel.bindableTextColor.value
      
      viewModel.bindableText.bind(observer: { [weak self] text in
        self?.textField.text = text
      })
      
      viewModel.bindableTextColor.bind(observer: { [weak self] color in
        self?.textField.textColor = color
      })
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
    viewModel?.didChangeInput(text: textField.text)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SingleLineTextInputView: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.isFirstResponder {
      viewModel?.didBeginEditing()
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    viewModel?.didEndEditing()
  }
}
