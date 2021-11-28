//
//  ItemDisplayDetailViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemDisplayDetailViewController: UIViewController {
  
  private var viewModel                 : ItemDisplayDetailViewModel
  private let swipeImageViewController  : SwipeImageViewController
  
  private let scrollView: UIScrollView = {
    let sv                                        = UIScrollView()
    sv.translatesAutoresizingMaskIntoConstraints  = false
    return sv
  }()
  
  private let mainContainer: UIStackView = {
    let view                                        = UIStackView()
    view.translatesAutoresizingMaskIntoConstraints  = false
    view.axis                                       = .vertical
    view.spacing                                    = 10
    return view
  }()

  private let closeButton: PulseRoundButton = {
    let button = PulseRoundButton(radius: 20)
    button.backgroundColor = Colors.primaryColorLight3
    button.setImage(Images.chevronDown, for: .normal)
    return button
  }()
  
  private let imageView         = UIView()
  private let userInfoView      = UserInfoView()
  private let itemInfoView      = ItemInfoView()

  init(viewModel: ItemDisplayDetailViewModel) {
    self.viewModel                = viewModel
    self.swipeImageViewController = SwipeImageViewController(viewModel: viewModel.swipeImageViewModel)
    
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLayout()
    configureBindables()
  }
  
  private func configureLayout() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
    
    configureScrollView()
    configureImageView()
    configureMainContainer()
    
    configureCloseButton()
  }
  
  private func configureScrollView() {
    view.addSubview(scrollView)
    scrollView.pinToEdges(of: view)
  }
  
  private func configureImageView() {
    bindChildViewController(child: swipeImageViewController, to: imageView)
  }
  
  private func configureMainContainer() {
    scrollView.addSubview(mainContainer)
    mainContainer.pinToEdges(of: scrollView)

    mainContainer.addArrangedSubview(imageView)
    mainContainer.addArrangedSubview(userInfoView)
    mainContainer.addArrangedSubview(itemInfoView)
    
    NSLayoutConstraint.activate([
      mainContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      mainContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      mainContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
      mainContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      mainContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      imageView.heightAnchor.constraint(equalToConstant: view.frame.width),
      userInfoView.heightAnchor.constraint(equalToConstant: 80)
    ])
  }
  
  private func configureCloseButton() {
    scrollView.addSubview(closeButton)
    
    NSLayoutConstraint.activate([
      closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
    ])
    
    closeButton.addTarget(self, action: #selector(onCloseButtonPress), for: .touchUpInside)
  }
  
  private func configureBindables() {
    userInfoView.imageView.image = viewModel.bindableUserImage.value
    viewModel.bindableUserImage.bind { [weak self] image in
      self?.userInfoView.imageView.image = image
    }
    
    userInfoView.nameLabel.text = viewModel.bindableUserNameText.value
    viewModel.bindableUserNameText.bind { [weak self] text in
      self?.userInfoView.nameLabel.text = text
    }
    
    userInfoView.locationLabel.text = viewModel.bindableLocationText.value
    viewModel.bindableLocationText.bind { [weak self] text in
      self?.userInfoView.locationLabel.text = text
    }
    
    itemInfoView.titleLabel.text = viewModel.bindableTitleText.value
    viewModel.bindableTitleText.bind { [weak self] text in
      self?.itemInfoView.titleLabel.text = text
    }
    
    itemInfoView.descriptionLabel.text = viewModel.bindableDescriptionText.value
    viewModel.bindableDescriptionText.bind { [weak self] text in
      self?.itemInfoView.descriptionLabel.text = text
    }
  }
  
  @objc private func onCloseButtonPress() {
    dismiss(animated: true, completion: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
