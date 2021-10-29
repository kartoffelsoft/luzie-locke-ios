//
//  DecimalInputCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class DecimalInputCell: UICollectionViewCell {
  
  static let reuseIdentifier = "DecimalInputCell"
  
  private let textField      = SingleLineInputTextField()
  
  var viewModel: DecimalInputCellViewModel?
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
    
    textField.delegate      = self
    textField.keyboardType  = UIKeyboardType.decimalPad
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

extension DecimalInputCell: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return viewModel?.isNextStringOkay(string) ?? false
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.textColor == .systemGray3 && textField.isFirstResponder {
      textField.text      = nil
      textField.textColor = Colors.primaryColor
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text, text.isEmpty || text == "" {
      textField.text      = placeholder
      textField.textColor = .systemGray3
    }
  }
}
