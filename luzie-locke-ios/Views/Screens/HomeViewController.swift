//
//  HomeViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class HomeViewController: UIViewController {
  
  enum Section { case main }
  
  let viewModel: HomeViewModel
  var items = [Item]()
  
  let setButton = KRoundButton(radius: 30)
  
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Home"))
    
    configureNavigationBar()
    configureCollectionView()
    configureDataSource()
    configureAddButton()
    
    let v = Item(_id: "abc", owner: nil, title: "abc", price: "12", description: "222", images: ["sbc"], counts: nil, state: "active", createdAt: Date())
             
    let v1 = Item(_id: "ab2c", owner: nil, title: "a3bc", price: "12", description: "222", images: ["sbc"], counts: nil, state: "active", createdAt: Date())
    items = [v, v1]
    
    updateData(on: items)
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
    
    collectionView                  = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
    collectionView.delegate         = self
    
    collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseIdentifier)
    
    view.addSubview(collectionView)
    
    if let image = CustomGradient.mainBackground(on: collectionView) {
      collectionView.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  func configureDataSource() {
      dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
          return cell
      })
  }

  func configureAddButton() {
    setButton.backgroundColor = Colors.primaryColor
    
    setButton.setImage(Images.floatingAdd, for: .normal)
    setButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
    
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
  
  @objc func handleAdd() {
    viewModel.navigateToItemCreate()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
  }
}
