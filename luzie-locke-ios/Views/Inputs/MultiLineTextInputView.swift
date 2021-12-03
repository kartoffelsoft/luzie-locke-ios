//
//  MultiLineTextInputView.swift
//  luzie-locke-ios
//
//  Created by Harry on 30.11.21.
//

import UIKit


protocol MultiLineTextInputViewDelegate: AnyObject {
  func didChangeInput(_ textView: UITextView)
}

class MultiLineTextInputView: UIView {
  weak var delegate: MultiLineTextInputViewDelegate?
  
  let textView = UITextView()
  
  var viewModel: InputViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      
      textView.text = viewModel.bindableText.value
      textView.textColor = viewModel.bindableTextColor.value
      
      viewModel.bindableText.bind(observer: { [weak self] text in
        self?.textView.text = text
      })
      
      viewModel.bindableTextColor.bind(observer: { [weak self] color in
        self?.textView.textColor = color
      })
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints           = false
    textView.translatesAutoresizingMaskIntoConstraints  = false
    
    addSubview(textView)
    textView.pinToEdges(of: self)
    
    textView.delegate                 = self
    textView.font                     = Fonts.body
    textView.isScrollEnabled          = false
    textView.isUserInteractionEnabled = true
    textView.backgroundColor          = .clear
    textView.textContainerInset       = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 6)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MultiLineTextInputView: UITextViewDelegate {

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.isFirstResponder {
      viewModel?.didBeginEditing()
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    viewModel?.didEndEditing()
  }
  
  func textViewDidChange(_ textView: UITextView) {
    viewModel?.didChangeInput(text: textView.text)
    delegate?.didChangeInput(textView)
  }
}
