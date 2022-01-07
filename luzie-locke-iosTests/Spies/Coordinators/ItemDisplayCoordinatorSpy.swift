//
//  ItemDisplayCoordinatorSpy.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 05.01.22.
//

import UIKit
@testable import luzie_locke_ios

class ItemDisplayCoordinatorSpy: ItemDisplayCoordinatorProtocol {
  
  struct PresentMoreCallLog {
    var callCount: Int
    var model: ItemDisplay?
  }
  
  struct NavigateToChatCallLog {
    var callCount: Int
    var remoteUserId: String?
    var itemId: String?
  }
  
  struct NavigateToItemUpdateCallLog {
    var callCount: Int
    var itemId: String?
  }
  
  var presentMoreCallLog: PresentMoreCallLog = PresentMoreCallLog(callCount: 0, model: nil)
  var navigateToChatCallLog: NavigateToChatCallLog = NavigateToChatCallLog(callCount: 0, itemId: nil)
  var navigateToItemUpdateCallLog: NavigateToItemUpdateCallLog = NavigateToItemUpdateCallLog(callCount: 0, itemId: nil)
  
  func presentMore(_ viewController: UIViewController, model: ItemDisplay) {
    presentMoreCallLog.callCount  += 1
    presentMoreCallLog.model      = model
  }
  
  func navigateToChat(remoteUserId: String, itemId: String) {
    navigateToChatCallLog.callCount     += 1
    navigateToChatCallLog.remoteUserId  = remoteUserId
    navigateToChatCallLog.itemId        = itemId
  }
  
  func navigateToItemUpdate(itemId: String) {
    navigateToItemUpdateCallLog.callCount += 1
    navigateToItemUpdateCallLog.itemId    = itemId
  }
}
