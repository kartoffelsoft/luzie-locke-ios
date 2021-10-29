//
//  SettingsViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class SettingsViewController: UIViewController {
  
  enum Section: Int {
    case profile = 0, userMenu, settingsMenu
    static var numberOfSections: Int { return 3 }
  }
  
  enum SettingsMenuRow: Int {
    case neibourhood = 0, logout
    static var numberOfSections: Int { return 2 }
  }
  
  private let viewModel: SettingsViewModel
  private let userMenuItems = [
    UserMenuItem(image: Images.listings, text: "Listings"),
    UserMenuItem(image: Images.purchases, text: "Purchaces"),
    UserMenuItem(image: Images.favorites, text: "Favorites")
  ]
  
  private let settingsMenuItems = [
    SettingsMenuItem(image: Images.location, text: "Verify neighbourhood"),
    SettingsMenuItem(image: Images.logout, text: "Logout")
  ]
  
  private var collectionView: UICollectionView!
  
  init(viewModel: SettingsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Settings"))
    
    configureNavigationBar()
    configureCollectionView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    viewModel.load()
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
    
    let layout = UICollectionViewCompositionalLayout { section, env in
      let padding: CGFloat = 15
      switch(Section(rawValue: section)) {
      case .profile:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
      
        return section
      case .userMenu:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
      
        return section
      case .settingsMenu:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
      default:
        return nil
      }
    }
    
    collectionView                  = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.delegate         = self
    collectionView.dataSource       = self
    
    collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
    collectionView.register(UserMenuCell.self, forCellWithReuseIdentifier: UserMenuCell.reuseIdentifier)
    collectionView.register(SettingsMenuCell.self, forCellWithReuseIdentifier: SettingsMenuCell.reuseIdentifier)
    view.addSubview(collectionView)
    
    if let image = CustomGradient.mainBackground(on: collectionView) {
      collectionView.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SettingsViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch Section(rawValue: indexPath.section) {
    case .profile:
      ()
    case .userMenu:
      ()
    case .settingsMenu:
      switch SettingsMenuRow(rawValue: indexPath.row) {
      case .neibourhood:
        viewModel.navigateToMap()
      case .logout:
        viewModel.logout()
        DispatchQueue.main.async {
          self.tabBarController?.selectedIndex = 0
          self.tabBarController?.viewDidAppear(false)
        }
      default:
        ()
      }
      
    default:
      ()
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.numberOfSections
  }
}

extension SettingsViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch(Section(rawValue: section)) {
    case .profile:
      return 1
    case .userMenu:
      return userMenuItems.count
    case .settingsMenu:
      return settingsMenuItems.count
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch(Section(rawValue: indexPath.section)) {
    case .profile:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as! ProfileCell
      cell.viewModel = viewModel.profileCellViewModel
      return cell
    case .userMenu:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserMenuCell.reuseIdentifier, for: indexPath) as! UserMenuCell
      cell.item = userMenuItems[indexPath.row]
      return cell
    case .settingsMenu:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsMenuCell.reuseIdentifier, for: indexPath) as! SettingsMenuCell
      cell.item = settingsMenuItems[indexPath.row]
      return cell
    default:
      return  UICollectionViewCell()
    }
  }
}
