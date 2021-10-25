//
//  SettingsViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class SettingsViewController: UICollectionViewController {

  static let profileViewId = "ProfileViewId"
  
  private let viewModel:      SettingsViewModel
  
  private let userMenuItems = [
    UserMenuItem(image: Images.listings, text: "Listings"),
    UserMenuItem(image: Images.purchases, text: "Purchaces"),
    UserMenuItem(image: Images.favorites, text: "Favorites")
  ]
  
  private let settingsMenuItems = [
    SettingsMenuItem(image: Images.location, text: "Verify neighbourhood"),
    SettingsMenuItem(image: Images.logout, text: "Logout")
  ]
  
  enum Section: Int {
    case profile = 0, userMenu, settingsMenu
    static var numberOfSections: Int { return 3 }
  }
  
  enum SettingsMenuRow: Int {
    case neibourhood = 0, logout
    static var numberOfSections: Int { return 2 }
  }
  
  init(viewModel: SettingsViewModel) {
    self.viewModel      = viewModel
    
    let layout = UICollectionViewCompositionalLayout { section, env in
      switch(Section(rawValue: section)) {
      case .profile:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(105)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
      
        return section
      case .userMenu:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(110)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
      
        return section
      case .settingsMenu:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
      default:
        return nil
      }
    }
    
    super.init(collectionViewLayout: layout)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Settings"))
    
    collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
    collectionView.register(UserMenuCell.self, forCellWithReuseIdentifier: UserMenuCell.reuseIdentifier)
    collectionView.register(SettingsMenuCell.self, forCellWithReuseIdentifier: SettingsMenuCell.reuseIdentifier)
    collectionView.backgroundColor = .systemBackground
    
    configureBindables()
    viewModel.load()
  }
  
  private func configureBindables() {
    viewModel.bindableProfileImage.bind { [weak self] (_) in
      self?.collectionView.reloadData()
    }
    
    viewModel.bindableUserName.bind { [weak self] (_) in
      self?.collectionView.reloadData()
    }
    
    viewModel.bindableUserLocation.bind { [weak self] (_) in
      self?.collectionView.reloadData()
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.numberOfSections
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch(Section(rawValue: indexPath.section)) {
    case .profile:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as! ProfileCell
      cell.userImageView.image    = viewModel.bindableProfileImage.value
      cell.userNameLabel.text     = viewModel.bindableUserName.value
      cell.userLocationLabel.text = viewModel.bindableUserLocation.value
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
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
