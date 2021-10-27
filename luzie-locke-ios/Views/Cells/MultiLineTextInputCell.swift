//
//  MultiLineTextInputCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.10.21.
//

import UIKit

class MultiLineTextInputCell: UICollectionViewCell {
  
  static let reuseIdentifier = "MultiLineTextInputCell"
  
  let textView = UITextView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.isUserInteractionEnabled                  = true
    textView.backgroundColor                           = .white

    addSubview(textView)

    textView.pinToEdges(of: self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
