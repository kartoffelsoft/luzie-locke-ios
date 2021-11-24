//
//  UserPurchasesViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.11.21.
//

import UIKit

class UserPurchasesViewController: UIViewController {
  
  enum Section { case main }
  
  private let viewModel:        UserPurchasesViewModel
  private var collectionView:   UICollectionView!
  private var dataSource:       UICollectionViewDiffableDataSource<Section, Item>!

  private let refreshControl  = UIRefreshControl()
  private let contentView     = UIView()
  
  init(viewModel: UserPurchasesViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBackground()
    configureCollectionView()
    configureDataSource()
    configureLayout()
    configureBindables()
    
    viewModel.viewDidLoad()
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
  
  private func configureCollectionView() {
    let padding: CGFloat    = 15
    let flowLayout          = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize     = CGSize(width: view.bounds.width - padding * 2, height: 100)
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.delegate         = self
    collectionView.backgroundColor  = .clear
    collectionView.refreshControl = refreshControl
    
    collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseIdentifier)

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
  
  private func configureLayout() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(collectionView)

    view.addSubview(contentView)
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    viewModel.bindableItems.bind { [weak self] items in
      guard let self = self else { return }
      if let items = items {
        self.updateData(on: items)
      }
    }
  }
  
  private func updateData(on items: [Item]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
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
  
  @objc private func handleRefresh() {
    viewModel.viewDidScrollToTop()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension UserPurchasesViewController: UICollectionViewDelegate {
  
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
