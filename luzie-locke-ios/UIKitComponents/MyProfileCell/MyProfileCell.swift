//
//  MyProfileCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 21.10.21.
//

import UIKit

class MyProfileCell: UICollectionViewCell {
  
  static let reuseIdentifier = "MyProfileCell"
  
  let userInfoView = UserInfoView()
  
  var viewModel: MyProfileCellViewModel? {
    didSet {
      userInfoView.imageView.image     = viewModel?.bindableProfileImage.value
      userInfoView.nameLabel.text      = viewModel?.bindableNameText.value
      userInfoView.locationLabel.text  = viewModel?.bindableLocationText.value
      
      viewModel?.bindableProfileImage.bind { [weak self] image in
        self?.userInfoView.imageView.image = image
      }
      
      viewModel?.bindableNameText.bind { [weak self] text in
        self?.userInfoView.nameLabel.text = text
      }
      
      viewModel?.bindableLocationText.bind { [weak self] text in
        self?.userInfoView.locationLabel.text = text
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    addSubview(userInfoView)
    userInfoView.pinToEdges(of: self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
