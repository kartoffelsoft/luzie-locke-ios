//
//  SettingsViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class SettingsViewController: UICollectionViewController {

  static let profileViewId = "ProfileViewId"
  
  private let profileStorage: AnyStorage<Profile>
  private let openHttpClient: OpenHTTPClient
  
  private let userMenuItems = [
    UserMenuItem(image: Images.listings, text: "Listings"),
    UserMenuItem(image: Images.purchases, text: "Purchaces"),
    UserMenuItem(image: Images.favorites, text: "Favorites")
  ]
  
  private let settingsMenuItems = [
    SettingsMenuItem(image: Images.location, text: "Verify neighbourhood"),
    SettingsMenuItem(image: Images.logout, text: "Logout")
  ]
  
  init(openHttpClient: OpenHTTPClient, profileStorage: AnyStorage<Profile>) {
    self.openHttpClient = openHttpClient
    self.profileStorage = profileStorage
    
    let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
      if sectionNumber == 0 {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
      
        return section
      } else if sectionNumber == 1 {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
      
        return section
      } else {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
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
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      return userMenuItems.count
    } else if section == 2 {
      return settingsMenuItems.count
    }
    
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch(indexPath.section) {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as! ProfileCell
      cell.profile        = profileStorage.get()
      cell.openHttpClient = openHttpClient
      cell.load()
      return cell
    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserMenuCell.reuseIdentifier, for: indexPath) as! UserMenuCell
      cell.item = userMenuItems[indexPath.row]
      return cell
    case 2:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsMenuCell.reuseIdentifier, for: indexPath) as! SettingsMenuCell
      cell.item = settingsMenuItems[indexPath.row]
      return cell
    default:
      ()
    }
    
    return UICollectionViewCell()
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.section, " ", indexPath.row)
//    switch indexPath.section {
//    case 0:
//
//    case 1:
//
//    default:
//      ()
//    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
