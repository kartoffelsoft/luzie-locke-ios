//
//  ItemDisplayBriefViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemDisplayBriefViewController: UIViewController {
  
  private var viewModel: ItemDisplayBriefViewModel
  
  private let swipeImageViewController: SwipeImageViewController
  
  private let imageView = UIView()
  private let moreButton = KRoundButton(radius: 20)
  
  init(viewModel: ItemDisplayBriefViewModel) {
    self.viewModel = viewModel
    self.swipeImageViewController = SwipeImageViewController(viewModel: viewModel.swipeImageViewModel)
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLayout()
    
    moreButton.addTarget(self, action: #selector(onMoreButtonPress), for: .touchUpInside)
  }
  
  @objc private func onMoreButtonPress() {
    print("pressed")
  }
  
  private func configureLayout() {
    bindChildViewController(child: swipeImageViewController, to: imageView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(imageView)
    view.addSubview(moreButton)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      moreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      moreButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
