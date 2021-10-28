//
//  UIView+Ext.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.10.21.
//

import UIKit

extension UIView {
  
  func pinToEdges(of superview: UIView, insets: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
      leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
    ])
  }
}
