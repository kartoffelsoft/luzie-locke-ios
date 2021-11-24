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
  
  enum UserMenuRow: Int {
    case listings = 0, purchases, favorites
    static var numberOfSections: Int { return 3 }
  }
  
  enum SettingsMenuRow: Int {
    case neighborhoodSetting = 0, verifyNeighborhood, logout
    static var numberOfSections: Int { return 3 }
  }
  
  private let viewModel: SettingsViewModel
  private let userMenuItems = [
    UserMenuItem(image: Images.listings, text: "Listings"),
    UserMenuItem(image: Images.purchases, text: "Purchaces"),
    UserMenuItem(image: Images.favorites, text: "Favorites")
  ]
  
  private let settingsMenuItems = [
    SettingsMenuItem(image: Images.location, text: "Neighborhood setting"),
    SettingsMenuItem(image: Images.location, text: "Verify neighborhood"),
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
    
    configureGradientBackground()
    configureNavigationBar()
    configureCollectionView()

  }
  
  override func viewDidAppear(_ animated: Bool) {
    viewModel.load()
  }
  
  func configureGradientBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  func configureNavigationBar() {
    if let navigationController = navigationController,
       let image = CustomGradient.navBarBackground(on: navigationController.navigationBar) {
      navigationController.navigationBar.barTintColor = UIColor(patternImage: image)
    }
  }
  
  private func configureCollectionView() {
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
    collectionView.backgroundColor  = .clear
    
    collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
    collectionView.register(UserMenuCell.self, forCellWithReuseIdentifier: UserMenuCell.reuseIdentifier)
    collectionView.register(SettingsMenuCell.self, forCellWithReuseIdentifier: SettingsMenuCell.reuseIdentifier)
    view.addSubview(collectionView)
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
      switch UserMenuRow(rawValue: indexPath.row) {
      case .listings:
        viewModel.didSelectListings()
      case .purchases:
        ()
      case .favorites:
        ()
      default:
        ()
      }
    case .settingsMenu:
      switch SettingsMenuRow(rawValue: indexPath.row) {
      case .neighborhoodSetting:
        print("Neighbourhood!")
      case .verifyNeighborhood:
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
      return UICollectionViewCell()
    }
  }
}
