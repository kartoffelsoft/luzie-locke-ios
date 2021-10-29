//
//  TextInputCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class TextInputCell: UICollectionViewCell {
  
  static let reuseIdentifier  = "TextInputCell"
  
  private let textField       = SingleLineInputTextField()
  
  var viewModel: TextInputCellViewModel?
  var placeholder: String? {
    didSet {
      textField.text      = placeholder
      textField.textColor = .systemGray3
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    addSubview(textField)
    
    textField.delegate = self
    textField.pinToEdges(of: self)
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
    if textField.textColor == .systemGray3 && textField.isFirstResponder {
      textField.text      = nil
      textField.textColor = Colors.primaryColorDark1
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text, text.isEmpty || text == "" {
      textField.text      = placeholder
      textField.textColor = .systemGray3
    }
  }
}
