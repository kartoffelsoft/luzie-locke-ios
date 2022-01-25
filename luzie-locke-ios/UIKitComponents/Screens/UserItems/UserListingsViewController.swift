//
//  UserListingsViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.11.21.
//

import UIKit

class UserListingsViewController: UIViewController {
  
  enum Section { case main }
  
  var viewModel: UserListingsViewModel?
  
  var openItemsViewController: OpenItemsViewController?
  var soldItemsViewController: SoldItemsViewController?
  
  private var segmentedControl: UISegmentedControl!
  private let contentView = UIView()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBackground()
    configureSegmentedControl()
    configureLayout()
    showListPerCurrentSegment()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
    navigationController?.isNavigationBarHidden = false
  }

  private func configureBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureSegmentedControl() {
    segmentedControl = UISegmentedControl(items: ["Open", "Sold"])
    segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
    
    segmentedControl.setTitleTextAttributes([
      NSAttributedString.Key.font: CustomUIFonts.body,
      NSAttributedString.Key.foregroundColor: UIColor.white
    ], for: .normal)
    
    segmentedControl.selectedSegmentTintColor = UIColor.custom.primaryColor
    segmentedControl.backgroundColor = UIColor.custom.primaryColorLight3
    segmentedControl.selectedSegmentIndex = 0
  }

  private func configureLayout() {
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(segmentedControl)
    view.addSubview(contentView)
    
    NSLayoutConstraint.activate([
      segmentedControl.heightAnchor.constraint(equalToConstant: 30),
      segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      contentView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
      contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  private func showListPerCurrentSegment() {
    guard let openItemsViewController = openItemsViewController,
          let soldItemsViewController = soldItemsViewController else { return }
    
    switch segmentedControl.selectedSegmentIndex {
    case 0:
      unbindChildViewController(child: soldItemsViewController)
      bindChildViewController(child: openItemsViewController, to: contentView)
    case 1:
      unbindChildViewController(child: openItemsViewController)
      bindChildViewController(child: soldItemsViewController, to: contentView)
    default: ()
    }
  }
  
  @objc private func handleSegmentChange() {
    showListPerCurrentSegment()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
