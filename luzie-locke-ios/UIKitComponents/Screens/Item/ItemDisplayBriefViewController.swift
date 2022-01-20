//
//  ItemDisplayBriefViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemDisplayBriefViewController: UIViewController {
  
  var viewModel: ItemDisplayBriefViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      swipeImageViewController.viewModel = viewModel.swipeImageViewModel
    }
  }
  
  private let swipeImageViewController: SwipeImageViewController
  
  private let imageView     = UIView()
  private let titleLabel    = HeaderLabel(font: CustomUIFonts.subtitle, textColor: UIColor.custom.secondaryColor, textAlignment: .left)
  private let locationLabel = HeaderLabel(font: CustomUIFonts.subtitle, textColor: UIColor.custom.primaryColorLight3, textAlignment: .left)
  private let moreButton    = PulseRoundButton(radius: 20)
  private let gradientLayer = CAGradientLayer()
  
  init() {
    self.swipeImageViewController = SwipeImageViewController()
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLayout()
    configureBindables()
  }
  
  override func viewWillLayoutSubviews() {
    gradientLayer.frame = self.view.frame
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
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.custom.primaryColor.cgColor]
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
      textStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      textStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
      textStackView.heightAnchor.constraint(equalToConstant: 50)
    ])

    textStackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    textStackView.isLayoutMarginsRelativeArrangement = true
  }
  
  private func configureMoreButton() {
    moreButton.backgroundColor = UIColor.custom.primaryColorLight3
    moreButton.setImage(Images.chevronUp, for: .normal)
    moreButton.animatePulse()
    
    view.addSubview(moreButton)
    
    NSLayoutConstraint.activate([
      moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      moreButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
    ])
    
    moreButton.addTarget(self, action: #selector(onMoreButtonPress), for: .touchUpInside)
  }
  
  private func configureBindables() {
    viewModel?.bindableTitleText.bind { [weak self] text in
      self?.titleLabel.text = text
    }
    
    viewModel?.bindableLocationText.bind { [weak self] text in
      self?.locationLabel.text = text
    }
  }
  
  @objc private func onMoreButtonPress() {
    viewModel?.didTapMoreButton(self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
