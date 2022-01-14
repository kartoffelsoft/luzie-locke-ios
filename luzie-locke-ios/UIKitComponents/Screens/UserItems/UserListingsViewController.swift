//
//  UserListingsViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.11.21.
//

import UIKit

class UserListingsViewController: UIViewController {
  
  enum Section { case main }
  
  var viewModel: UserListingsViewModel? {
    didSet {
      viewModel?.delegate = self
    }
  }
  
  private var segmentedControl: UISegmentedControl!
  private var collectionView:   UICollectionView!
  private var dataSource:       UICollectionViewDiffableDataSource<Section, ItemListElement>!

  private let refreshControl  = UIRefreshControl()
  private let contentView     = UIView()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBackground()
    configureSegmentedControl()
    configureCollectionView()
    configureDataSource()
    configureLayout()
    configureBindables()
    
    viewModel?.viewDidLoad()
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
    
    segmentedControl.selectedSegmentTintColor = CustomUIColors.primaryColor
    segmentedControl.backgroundColor          = CustomUIColors.primaryColorLight3
    segmentedControl.selectedSegmentIndex     = 0
  }
  
  private func configureCollectionView() {
    let padding: CGFloat    = 15
    let flowLayout          = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize     = CGSize(width: view.bounds.width - padding * 2, height: 100)
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.delegate         = self
    collectionView.backgroundColor  = .clear
    collectionView.refreshControl   = refreshControl
    
    collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseIdentifier)

    refreshControl.tintColor = CustomUIColors.primaryColor
    refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, ItemListElement>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
      cell.viewModel = self?.viewModel?.itemCellViewModels[indexPath.row]
      return cell
    })
  }
  
  private func configureLayout() {
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(collectionView)

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
      
      collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  private func configureBindables() {
    viewModel?.bindableItems.bind { [weak self] items in
      guard let self = self else { return }
      if let items = items {
        self.updateData(on: items)
      }
    }
  }
  
  private func updateData(on items: [ItemListElement]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, ItemListElement>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items)
    
    DispatchQueue.main.async {
      self.refreshControl.endRefreshing()
      self.dataSource.apply(snapshot, animatingDifferences: true)
      
      if items.isEmpty {
        self.showEmptyStateView(with: "No item to show.", in: self.contentView)
      } else {
        self.removeEmptyStateView(in: self.contentView)
      }
    }
  }
  
  @objc private func handleSegmentChange() {
    viewModel?.didChangeSegment(segment: segmentedControl.selectedSegmentIndex)
  }
  
  @objc private func handleRefresh() {
    viewModel?.viewDidScrollToTop()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension UserListingsViewController: UICollectionViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let offsetY         = scrollView.contentOffset.y
    let height          = scrollView.frame.height
    let contentHeight   = scrollView.contentSize.height

    if(offsetY > contentHeight - height)  {
      viewModel?.viewDidScrollToBottom()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.didSelectItemAt(indexPath: indexPath)
  }
}

extension UserListingsViewController: UserListingsViewModelDelegate {
  
  func didGetError(_ error: LLError) {
    presentAlertOnMainThread(
      title: "Unable to complete",
      message: error.rawValue,
      buttonTitle: "OK") {
        self.refreshControl.endRefreshing()
    }
  }
}
