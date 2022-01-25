//
//  SoldItemsViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.01.22.
//

import UIKit
import Combine

class SoldItemsViewController: UIViewController {
  
  enum Section { case main }
  
  var viewModel: SoldItemsViewModel? {
    didSet {
      viewModel?.delegate = self
    }
  }
  
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, ItemListElement>!

  private let refreshControl = UIRefreshControl()
  private let contentView = UIView()
  
  private var subscriptions = Set<AnyCancellable>()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureBackground()
    configureCollectionView()
    configureDataSource()
    configureLayout()
    configureSubscriptions()
    
    viewModel?.viewDidLoad()
  }

  private func configureBackground() {
    if let image = CustomGradient.mainBackground(on: contentView) {
      contentView.backgroundColor = UIColor(patternImage: image)
    }
  }

  private func configureCollectionView() {
    let padding: CGFloat = 15
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: view.bounds.width - padding * 2, height: 100)
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.delegate = self
    collectionView.backgroundColor = .clear
    collectionView.refreshControl = refreshControl
    
    collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseIdentifier)

    refreshControl.tintColor = UIColor.custom.primaryColor
    refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
  }
  
  private func configureNavigationBar() {
    if let navigationController = navigationController,
       let image = CustomGradient.navBarBackground(on: navigationController.navigationBar) {
      navigationController.navigationBar.barTintColor = UIColor(patternImage: image)
    }
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, ItemListElement>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
      cell.viewModel = self?.viewModel?.itemCellViewModels[indexPath.row]
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
  
  private func configureSubscriptions() {
    viewModel?.observableItems.sink { items in
        self.updateData(on: items)
    }.store(in: &subscriptions)
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
  
  @objc private func handleRefresh() {
    viewModel?.viewDidScrollToTop()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SoldItemsViewController: UICollectionViewDelegate {
  
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

extension SoldItemsViewController: SoldItemsViewModelDelegate {
  
  func didGetError(_ error: LLError) {
    presentAlertOnMainThread(
      title: "Unable to complete",
      message: error.localizedDescription,
      buttonTitle: "OK") {
        self.refreshControl.endRefreshing()
    }
  }
}
