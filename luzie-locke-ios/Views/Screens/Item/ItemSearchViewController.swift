//
//  SearchViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class ItemSearchViewController: UIViewController {
  
  private let searchController = UISearchController()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureGradientBackground()
    configureSearchController()
  }

//  override func viewWillAppear(_ animated: Bool) {
//      super.viewWillAppear(animated)
//      navigationController?.setNavigationBarHidden(true, animated: animated)
//  }
//
//  override func viewWillDisappear(_ animated: Bool) {
//      super.viewWillDisappear(animated)
//      navigationController?.setNavigationBarHidden(false, animated: animated)
//  }
  
  func configureGradientBackground() {
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

    
//    searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search anything...", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
    navigationItem.searchController             = searchController
    navigationItem.hidesSearchBarWhenScrolling  = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension ItemSearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
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
