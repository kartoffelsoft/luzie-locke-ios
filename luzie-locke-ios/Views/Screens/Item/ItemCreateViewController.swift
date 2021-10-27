//
//  ItemCreateViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 26.10.21.
//

import UIKit

class ItemCreateViewController: UIViewController {
  
  enum Section: Int {
    case imageSelect = 0, title, price, description
    static var numberOfSections: Int { return 4 }
  }
  
  static let headerId = "HeaderId"
  
  private var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
  }
  
  private func configureCollectionView() {
    let padding: CGFloat    = 15
    let flowLayout          = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize     = CGSize(width: view.bounds.width - padding * 2, height: 100)
    
    let layout = UICollectionViewCompositionalLayout { section, env in
      let padding: CGFloat = 8
      switch(Section(rawValue: section)) {
      case .imageSelect:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
      case .title:
        fallthrough
        
      case .price:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
      case .description:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(176)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
      default:
        return nil
      }
    }
    
    collectionView                  = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.delegate         = self
    collectionView.dataSource       = self
    collectionView.backgroundColor  = .systemGray6
    
    collectionView.register(ImageSelectCell.self, forCellWithReuseIdentifier: ImageSelectCell.reuseIdentifier)
    collectionView.register(TextInputCell.self, forCellWithReuseIdentifier: TextInputCell.reuseIdentifier)
    collectionView.register(NumberInputCell.self, forCellWithReuseIdentifier: NumberInputCell.reuseIdentifier)
    collectionView.register(MultiLineTextInputCell.self, forCellWithReuseIdentifier: MultiLineTextInputCell.reuseIdentifier)
    
    view.addSubview(collectionView)
  }
}

extension ItemCreateViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch Section(rawValue: indexPath.section) {
    case .imageSelect:
      ()
    case .title:
      ()
    case .price:
      ()
    case .description:
      ()
    default:
      ()
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.numberOfSections
  }
}

extension ItemCreateViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch Section(rawValue: indexPath.section) {
    case .imageSelect:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSelectCell.reuseIdentifier, for: indexPath) as! ImageSelectCell
      return cell
    case .title:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextInputCell.reuseIdentifier, for: indexPath) as! TextInputCell
      cell.textField.placeholder = "Title"
      return cell
    case .price:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberInputCell.reuseIdentifier, for: indexPath) as! NumberInputCell
      cell.textField.placeholder = "Price"
      return cell
    case .description:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultiLineTextInputCell.reuseIdentifier, for: indexPath) as! MultiLineTextInputCell
//      cell.textField.placeholder = "Description"
      return cell
    default:
      return  UICollectionViewCell()
    }
  }
}
