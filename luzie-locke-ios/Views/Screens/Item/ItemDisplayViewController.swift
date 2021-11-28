//
//  ItemMainViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import UIKit

class ItemDisplayViewController: UIViewController {

  weak var coordinator: ItemDisplayCoordinator?
  
  private let viewModel:            ItemDisplayViewModel
  private let itemActionPanelView:  ItemActionPanelView
  
  private let contentView = UIView()
  private let briefViewController: ItemDisplayBriefViewController
  
  init(viewModel: ItemDisplayViewModel) {
    self.viewModel            = viewModel
    self.itemActionPanelView  = ItemActionPanelView(viewModel: viewModel.itemActionPanelViewModel)
    self.briefViewController  = ItemDisplayBriefViewController(viewModel: viewModel.itemDisplayBriefViewModel)
    super.init(nibName: nil, bundle: nil)
    
    self.itemActionPanelView.delegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
    
    configureLayout()
    configureBindables()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
  }
    
  private func configureBindables() {
//    viewModel.bindablePriceText.bind { [weak self] text in
//      self?.itemActionPanelView.priceLabel.attributedText = text
//    }
  }
  
  private func configureLayout() {
    bindChildViewController(child: briefViewController, to: contentView)
    
    let bottomSafeAreaView = UIView()
    bottomSafeAreaView.backgroundColor = Colors.primaryColor
    bottomSafeAreaView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(contentView)
    view.addSubview(itemActionPanelView)
    view.addSubview(bottomSafeAreaView)
    
    NSLayoutConstraint.activate([
      itemActionPanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      itemActionPanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      itemActionPanelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      itemActionPanelView.heightAnchor.constraint(equalToConstant: 70),
      
      bottomSafeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomSafeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomSafeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomSafeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      contentView.topAnchor.constraint(equalTo: view.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: itemActionPanelView.topAnchor),
    ])
    
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ItemDisplayViewController: ItemActionPanelViewDelegate {
  
  func didTapDeleteButton() {
    presentConfirmOnMainThread(
      title: "Are you sure?",
      message: "The item will be deleted and cannot be recovered.") {
      self.viewModel.didTapDeleteButton()
    }
  }
}
