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
  
  private let imageView     = UIView()
  private let titleLabel    = HeaderLabel(font: Fonts.subtitle, textColor: Colors.secondaryColor, textAlignment: .left)
  private let locationLabel = HeaderLabel(font: Fonts.subtitle, textColor: Colors.primaryColorLight3, textAlignment: .left)
  private let moreButton    = KRoundButton(radius: 20)
  private let gradientLayer = CAGradientLayer()
  
  init(viewModel: ItemDisplayBriefViewModel) {
    self.viewModel = viewModel
    self.swipeImageViewController = SwipeImageViewController(viewModel: viewModel.swipeImageViewModel)
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLayout()
    configureBindables()
    
    moreButton.addTarget(self, action: #selector(onMoreButtonPress), for: .touchUpInside)
  }
  
  override func viewWillLayoutSubviews() {
    gradientLayer.frame = self.view.frame
  }
  
  @objc private func onMoreButtonPress() {
    print("pressed")
  }
  
  private func configureLayout() {
    configureImageView()
    configureGradientLayer()
    configureLabels()
    configureMoreButton()
    
  }
  
  private func configureImageView() {
    bindChildViewController(child: swipeImageViewController, to: imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func configureGradientLayer() {
    gradientLayer.colors = [UIColor.clear.cgColor, Colors.primaryColor.cgColor]
    gradientLayer.locations = [0.5, 1.0]
    view.layer.addSublayer(gradientLayer)
  }
  
  private func configureLabels() {
    let textStackView = UIStackView(arrangedSubviews: [titleLabel, locationLabel])
    textStackView.translatesAutoresizingMaskIntoConstraints = false
    textStackView.axis                                      = .vertical
    textStackView.distribution                              = .equalSpacing
    
    view.addSubview(textStackView)
    
    NSLayoutConstraint.activate([
      textStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
      textStackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
      textStackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50),
      textStackView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func configureMoreButton() {
    moreButton.backgroundColor = Colors.primaryColorLight3
    moreButton.setImage(Images.chevronUp, for: .normal)
    moreButton.animatePulse()
    
    view.addSubview(moreButton)
    
    NSLayoutConstraint.activate([
      moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      moreButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
    ])
  }
  
  private func configureBindables() {
    viewModel.bindableTitleText.bind { [weak self] text in
      self?.titleLabel.text = text
    }
    
    viewModel.bindableLocationText.bind { [weak self] text in
      self?.locationLabel.text = text
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
