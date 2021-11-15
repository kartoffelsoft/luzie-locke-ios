//
//  TextInputCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class TextInputCell: UICollectionViewCell {
  
  static let reuseIdentifier    = "TextInputCell"
  
  private let textField         = SingleLineInputTextField()
  private let placeholderColor  = Colors.primaryColorLight1
  
  var viewModel: TextInputCellViewModel?
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
    addSubview(textField)

    textField.pinToEdges(of: self)
    textField.delegate = self
    textField.backgroundColor = Colors.primaryColorLight3.withAlphaComponent(0.2)
    textField.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
  }

  @objc private func handleInputChange(textField: UITextField) {
    viewModel?.text = textField.text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TextInputCell: UITextFieldDelegate {
  
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
