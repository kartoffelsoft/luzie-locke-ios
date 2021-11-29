//
//  HomeViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class HomeViewController: UIViewController {
  
  enum Section { case main }
  
  private let viewModel: HomeViewModel

  private var collectionView: UICollectionView!
  private var dataSource:     UICollectionViewDiffableDataSource<Section, Item>!
  
  private let setButton       = PulseRoundButton(radius: 30)
  private let locationButton  = LocationMenuButton()
  private let refreshControl  = UIRefreshControl()
  
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewModel.delegate = self
    
    locationButton.addTarget(self, action: #selector(handleMenuTap), for: .touchUpInside)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: locationButton)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.search, style: .plain, target: self, action: #selector(handleSearchTap))
    
    configureBackground()
    configureNavigationBar()
    configureCollectionView()
    configureDataSource()
    configureBindables()
    configureAddButton()
    
    viewModel.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleDidUpdateItemList), name: .didUpdateItemList, object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = false
  }
  
  private func configureBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureNavigationBar() {
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
    
    collectionView.refreshControl = refreshControl
    refreshControl.tintColor      = Colors.primaryColor
    refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
      cell.viewModel = self?.viewModel.itemCellViewModels[indexPath.row]
      return cell
    })
  }
  
  private func configureBindables() {
    viewModel.bindableItems.bind { [weak self] items in
      if let items = items {
        self?.updateData(on: items)
      }
    }
  }
  
  private func configureAddButton() {
    setButton.backgroundColor = Colors.primaryColor
    
    setButton.setImage(Images.floatingAdd, for: .normal)
    setButton.addTarget(self, action: #selector(handleAddTap), for: .touchUpInside)
    
    view.addSubview(setButton)
    
    NSLayoutConstraint.activate([
      setButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
      setButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
    ])
  }
  
  private func updateData(on items: [Item]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items)
    
    DispatchQueue.main.async {
      self.refreshControl.endRefreshing()
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
  
  @objc private func handleAddTap() {
    viewModel.navigateToItemCreate()
  }
  
  @objc private func handleMenuTap(sender: UIButton) {
    let vc = LocationMenuViewController()
    vc.preferredContentSize   = CGSize(width:200, height:100)
    vc.modalPresentationStyle = UIModalPresentationStyle.popover
  
    guard let popoverController = vc.popoverPresentationController else { return }
    popoverController.barButtonItem = navigationItem.leftBarButtonItem
    popoverController.delegate      = self
    locationButton.isMenuOpen       = true

    self.present(vc, animated: true, completion: nil)
  }
  
  @objc private func handleSearchTap() {
    viewModel.navigateToItemSearch()
  }
  
  @objc private func handleRefresh() {
    viewModel.viewDidScrollToTop()
  }
  
  @objc private func handleDidUpdateItemList() {
    viewModel.viewDidUpdateItemList()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeViewController: UICollectionViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let offsetY         = scrollView.contentOffset.y
    let height          = scrollView.frame.height
    let contentHeight   = scrollView.contentSize.height

    if(offsetY > contentHeight - height)  {
      viewModel.viewDidScrollToBottom()
    }
  }
  
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

extension HomeViewController: HomeViewModelDelegate {
  
  func didGetError(_ error: LLError) {
    presentAlertOnMainThread(
      title: "Unable to complete",
      message: error.rawValue,
      buttonTitle: "OK") {
        self.refreshControl.endRefreshing()
    }
  }
}
