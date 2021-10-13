//
//  SearchViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class SearchViewController: UIViewController {

    var userStorage: UserStorage
    
    init(userStorage: UserStorage) {
        self.userStorage = userStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Search"))
        configureSearchController()
    }
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for an item"
        searchController.obscuresBackgroundDuringPresentation   = false
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
