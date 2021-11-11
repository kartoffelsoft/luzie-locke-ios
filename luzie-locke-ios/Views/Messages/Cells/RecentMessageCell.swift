//
//  InboxCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import UIKit

class RecentMessageCell: UICollectionViewCell {
  
  static let reuseIdentifier = "RecentMessageCell"
    
  var message: RecentMessage! {
    didSet {
      
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  fileprivate func configure() {
    backgroundColor = .green
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
