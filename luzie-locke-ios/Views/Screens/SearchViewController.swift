//
//  SearchViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class SearchViewController: UIViewController {
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Search"))
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
    let searchController                                    = UISearchController()
    searchController.searchResultsUpdater                   = self
    searchController.obscuresBackgroundDuringPresentation   = false
//    searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search anything...", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
    navigationItem.searchController                         = searchController
    navigationItem.hidesSearchBarWhenScrolling              = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension SearchViewController: UISearchResultsUpdating {
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
