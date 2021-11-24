//
//  SearchViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit
import Combine

class ItemSearchViewController: UIViewController {
  
  enum Section { case main }
  
  private let viewModel: ItemSearchViewModel

  private var debounceTimer:  Timer?
  private var collectionView: UICollectionView!
  private var dataSource:     UICollectionViewDiffableDataSource<Section, Item>!

  private let searchController = UISearchController()

  init(viewModel: ItemSearchViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBackground()
    configureSearchController()
    configureCollectionView()
    configureDataSource()
    configureBindables()
  }
  
  func configureBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  func configureSearchController() {
    searchController.searchResultsUpdater                       = self
    searchController.obscuresBackgroundDuringPresentation       = false
    searchController.searchBar.placeholder                      = ""
    searchController.searchBar.searchTextField.tintColor        = Colors.primaryColor
    searchController.searchBar.searchTextField.backgroundColor  = Colors.primaryColorLight2.withAlphaComponent(0.1)
    searchController.searchBar.setImage(Images.search, for: .search, state: .normal)
    
    navigationItem.searchController             = searchController
    navigationItem.hidesSearchBarWhenScrolling  = false
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
      cell.viewModel = self?.viewModel.itemCellViewModels[indexPath.row]
      return cell
    })
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
  }
  
  private func configureBindables() {
    viewModel.bindableItems.bind { [weak self] items in
      if let items = items {
        self?.updateData(on: items)
      }
    }
  }
  
  private func updateData(on items: [Item]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items)
    
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ItemSearchViewController: UICollectionViewDelegate {
  
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

extension ItemSearchViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    debounceTimer?.invalidate()
    debounceTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
      guard let keyword = searchController.searchBar.text else {
        return
      }
      
      self?.viewModel.viewDidSetSearchKeyword(keyword)
    }

    //        guard let keyword = searchController.searchBar.text, !keyword.isEmpty else {
    //            isSearching = false
    //            filteredFollowers.removeAll()
    //            updateData(on: followers)
    //            return
    //        }
    //        isSearching = true
    //        filteredFollowers = followers.filter { $0.login.lowercased().contains(keyword.lowercased()) }
    //        updateData(on: filteredFollowers)
  }
}
