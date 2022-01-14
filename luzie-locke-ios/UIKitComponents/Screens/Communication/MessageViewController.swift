//
//  NegotiationViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.01.22.
//

import UIKit

class MessageViewController: UIViewController {

  var viewModel: MessageViewModel?
  
  private let itemView = ItemSingleLineView()
  private let chatView = UIView()
  
  var chatViewController: ChatViewController?

  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBackground()
    configureLayout()
    configureBindables()
    
    viewModel?.didLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
  }
  
  private func configureBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureLayout() {
    itemView.translatesAutoresizingMaskIntoConstraints = false
    chatView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(itemView)
    view.addSubview(chatView)
    
    NSLayoutConstraint.activate([
      itemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      itemView.heightAnchor.constraint(equalToConstant: 60),
      
      chatView.topAnchor.constraint(equalTo: itemView.bottomAnchor),
      chatView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      chatView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      chatView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    if let chatViewController = chatViewController {
      bindChildViewController(child: chatViewController, to: chatView)
    }

    itemView.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: #selector(handleItemViewTap)))
  }
  
  private func configureBindables() {
    itemView.image = viewModel?.bindableItemImage.value
    itemView.stateText = viewModel?.bindableStateText.value
    itemView.titleText = viewModel?.bindableTitleText.value

    viewModel?.bindableItemImage.bind { [weak self] image in
      DispatchQueue.main.async {
        self?.itemView.image = image
      }
    }
    
    viewModel?.bindableStateText.bind { [weak self] text in
      DispatchQueue.main.async {
        self?.itemView.stateText = text
      }
    }
    
    viewModel?.bindableTitleText.bind { [weak self] text in
      DispatchQueue.main.async {
        self?.itemView.titleText = text
      }
    }
  }
  
  @objc private func handleItemViewTap() {
    viewModel?.didTapItemView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
