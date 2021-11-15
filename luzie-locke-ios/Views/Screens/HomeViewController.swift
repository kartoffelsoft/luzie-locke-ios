//
//  HomeViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class HomeViewController: UIViewController {
  
  enum Section { case main }
  
  let viewModel:      HomeViewModel
  var collectionView: UICollectionView!
  var dataSource:     UICollectionViewDiffableDataSource<Section, Item>!
  
  var items           = [Item]()
  let setButton       = KRoundButton(radius: 30)
  let locationButton  = LocationMenuButton()
  
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Home"))
    locationButton.addTarget(self, action: #selector(handleMenuTap), for: .touchUpInside)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: locationButton)
    
//    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Kronberg", style: .plain, target: self, action: #selector(handleMenuTap))

//    navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.upload, style: .plain, target: self, action: #selector(handleMenuTap))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.search, style: .plain, target: self, action: #selector(handleSearchTap))
    
    configureGradientBackground()
    configureNavigationBar()
    configureCollectionView()
    configureDataSource()
    configureBindables()
    configureAddButton()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    viewModel.queryAllItems()
  }
  
  func configureGradientBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  func configureNavigationBar() {
    if let navigationController = navigationController,
       let image = CustomGradient.navBarBackground(on: navigationController.navigationBar) {
      navigationController.navigationBar.barTintColor = UIColor(patternImage: image)
    }
  }
  
  private func configureCollectionView() {
    let padding: CGFloat    = 15
    let flowLayout          = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize     = CGSize(width: view.bounds.width - padding * 2, height: 100)
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
    collectionView.delegate         = self
    collectionView.backgroundColor  = .clear
    
    collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseIdentifier)
    
    view.addSubview(collectionView)
    
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
      cell.viewModel = self?.viewModel.itemCellViewModels[indexPath.row]
      return cell
    })
  }
  
  func configureBindables() {
    viewModel.bindableItems.bind { [weak self] items in
      if let items = items {
        self?.updateData(on: items)
      }
    }
  }
  
  func configureAddButton() {
    setButton.backgroundColor = Colors.primaryColor
    
    setButton.setImage(Images.floatingAdd, for: .normal)
    setButton.addTarget(self, action: #selector(handleAddTap), for: .touchUpInside)
    
    view.addSubview(setButton)
    
    NSLayoutConstraint.activate([
      setButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
      setButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
    ])
  }
  
  func updateData(on items: [Item]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items)
    
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
  
  @objc func handleAddTap() {
    viewModel.navigateToItemCreate()
  }
  
  @objc func handleMenuTap(sender: UIButton) {
    let vc = LocationMenuViewController()
    vc.preferredContentSize   = CGSize(width:200, height:100)
    vc.modalPresentationStyle = UIModalPresentationStyle.popover
  
    guard let popoverController = vc.popoverPresentationController else { return }
    popoverController.barButtonItem = navigationItem.leftBarButtonItem
    popoverController.delegate      = self
    locationButton.isMenuOpen       = true

    self.present(vc, animated: true, completion: nil)
  }
  
  @objc func handleSearchTap() {
    viewModel.navigateToItemSearch()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.didSelectItemAt(indexPath: indexPath)
  }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
  
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
      return .none
  }
  
  func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
    locationButton.isMenuOpen = false
    return true
  }
}
