//
//  UserListingsViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.11.21.
//

import UIKit

class UserListingsViewController: UIViewController {
  
  enum Section { case main }
  
  private let viewModel: UserListingsViewModel
  private var segmentedControl: UISegmentedControl!
  private var collectionView: UICollectionView!
  private var dataSource:     UICollectionViewDiffableDataSource<Section, Item>!
  
  init(viewModel: UserListingsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBarController?.tabBar.isHidden = true
    
    configureGradientBackground()
    configureSegmentedControl()
    configureCollectionView()
    configureDataSource()
    configureLayout()
    configureBindables()
    
    viewModel.viewDidLoad()
  }

  private func configureGradientBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureSegmentedControl() {
    segmentedControl = UISegmentedControl(items: ["Open", "Closed"])
    segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
    
    segmentedControl.setTitleTextAttributes([
      NSAttributedString.Key.font: Fonts.body,
      NSAttributedString.Key.foregroundColor: UIColor.white//Colors.primaryColor
    ], for: .normal)
    
    segmentedControl.selectedSegmentTintColor = Colors.primaryColorLight1
    segmentedControl.backgroundColor          = Colors.primaryColorLight3
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
    
    
    collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseIdentifier)
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
      cell.viewModel = self?.viewModel.itemCellViewModels[indexPath.row]
      return cell
    })
  }
  
  private func configureLayout() {
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(segmentedControl)
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      segmentedControl.heightAnchor.constraint(equalToConstant: 30),
      segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
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
//      self.refreshControl.endRefreshing()
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
  
  @objc private func handleSegmentChange() {
    print(segmentedControl.selectedSegmentIndex)
    viewModel.didChangeSegment(segment: segmentedControl.selectedSegmentIndex)
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
//      viewModel.viewDidScrollToBottom()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    viewModel.didSelectItemAt(indexPath: indexPath)
  }
}
