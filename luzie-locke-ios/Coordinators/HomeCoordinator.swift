//
//  HomeCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

class HomeCoordinator: Coordinator {
  
  var children = [Coordinator]()
  var navigationController: UINavigationController
  
  let profileStorage:   AnyStorage<User>
  let cloudStorage:     CloudStorage
  let openHttpClient:   OpenHTTP
  let itemRepository:   ItemRepository
  
  init(navigationController:  UINavigationController,
       profileStorage:        AnyStorage<User>,
       cloudStorage:          CloudStorage,
       openHttpClient:        OpenHTTP,
       itemRepository:        ItemRepository) {
    self.navigationController = navigationController
    self.profileStorage       = profileStorage
    self.cloudStorage         = cloudStorage
    self.openHttpClient       = openHttpClient
    self.itemRepository       = itemRepository
    
    let vm = HomeViewModel(coordinator: self,
                           profileStorage: profileStorage,
                           openHttpClient: openHttpClient,
                           itemRepository: itemRepository)
    let vc = HomeViewController(viewModel: vm)
    
    vc.tabBarItem = UITabBarItem(title: nil,
                                 image: Images.home,
                                 selectedImage: Images.home)
    
    navigationController.pushViewController(vc, animated: false)
  }
  
  func start() {
  }
  
  func navigateToItemCreate() {
    let vm = ItemCreateViewModel(coordinator: self,
                                 profileStorage: profileStorage,
                                 cloudStorage: cloudStorage,
                                 openHttpClient: openHttpClient,
                                 itemRepository: itemRepository)
    let vc = ItemCreateViewController(viewModel: vm)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func navigateToItemDisplay(id: String) {
    let vm = ItemDisplayViewModel(coordinator: self,
                                  profileStorage: profileStorage,
                                  openHttpClient: openHttpClient,
                                  itemRepository: itemRepository,
                                  id: id)
    let vc = ItemDisplayViewController(viewModel: vm)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
