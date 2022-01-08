//
//  SettingsCoordinatorSpy.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 08.01.22.
//

import UIKit
@testable import luzie_locke_ios

class SettingsCoordinatorSpy: SettingsCoordinatorProtocol {
  
  struct NavigateToUserListingsCallLog {
    var callCount: Int
  }
  
  struct NavigateToUserPurchasesCallLog {
    var callCount: Int
  }
  
  struct NavigateToUserFavoritesCallLog {
    var callCount: Int
  }
  
  struct NavigateToNeighborhooodSettingCallLog {
    var callCount: Int
  }
  
  struct NavigateToVerifyNeighborhoodCallLog {
    var callCount: Int
  }
  
  struct NavigateToItemDisplayCallLog {
    var callCount: Int
    var id: String?
  }
  
  var navigateToUserListingsCallLog = NavigateToUserListingsCallLog(callCount: 0)
  var navigateToUserPurchasesCallLog = NavigateToUserPurchasesCallLog(callCount: 0)
  var navigateToUserFavoritesCallLog = NavigateToUserFavoritesCallLog(callCount: 0)
  var navigateToNeighborhooodSettingCallLog = NavigateToNeighborhooodSettingCallLog(callCount: 0)
  var navigateToVerifyNeighborhoodCallLog = NavigateToVerifyNeighborhoodCallLog(callCount: 0)
  var navigateToItemDisplayCallLog = NavigateToItemDisplayCallLog(callCount: 0, id: nil)
  
  func navigateToUserListings() {
    navigateToUserListingsCallLog.callCount += 1
  }
  
  func navigateToUserPurchases() {
    navigateToUserPurchasesCallLog.callCount += 1
  }
  
  func navigateToUserFavorites() {
    navigateToUserFavoritesCallLog.callCount += 1
  }
  
  func navigateToNeighborhooodSetting() {
    navigateToNeighborhooodSettingCallLog.callCount += 1
  }
  
  func navigateToVerifyNeighborhood() {
    navigateToVerifyNeighborhoodCallLog.callCount += 1
  }
  
  func navigateToItemDisplay(id: String) {
    navigateToItemDisplayCallLog.callCount += 1
    navigateToItemDisplayCallLog.id        = id
  }
}
