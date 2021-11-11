//
//  MessagesViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController {
  
  var viewModel: MessagesViewModel?
  
  private var collectionView: UICollectionView!
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Chat"))
    configureGradientBackground()
    configureCollectionView()
    configureBindables()
    
    viewModel?.didLoad()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if isMovingFromParent {
      viewModel?.willDisappear()
    }
  }
  
  func configureGradientBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  func configureCollectionView() {
    let layout = UICollectionViewCompositionalLayout { section, env in
      let padding: CGFloat = 15
      let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)))
      item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
      
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      
      return section
    }
    
    collectionView                  = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.delegate         = self
    collectionView.dataSource       = self
    collectionView.backgroundColor  = .clear
    
    collectionView.register(RecentMessageCell.self, forCellWithReuseIdentifier: RecentMessageCell.reuseIdentifier)
    view.addSubview(collectionView)
  }
  
  func configureBindables() {
    viewModel?.bindableMessages.bind { [weak self] messages in
      print("@@@@")
      print(messages)
      self?.collectionView.reloadData()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MessagesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.didSelectItemAt(indexPath: indexPath)
  }
}

extension MessagesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentMessageCell.reuseIdentifier, for: indexPath) as! RecentMessageCell
    cell.message = viewModel?.bindableMessages.value![indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let messages = viewModel?.bindableMessages.value {
      return messages.count
    }
    return 0
  }
}
