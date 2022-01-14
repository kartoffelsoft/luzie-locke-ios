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
  
  struct NavigateToCommunicationCallLog {
    var callCount: Int
    var remoteUserId: String?
    var itemId: String?
  }
  
  struct NavigateToItemUpdateCallLog {
    var callCount: Int
    var itemId: String?
  }
  
  var presentMoreCallLog = PresentMoreCallLog(callCount: 0, model: nil)
  var navigateToCommunicationCallLog = NavigateToCommunicationCallLog(callCount: 0, itemId: nil)
  var navigateToItemUpdateCallLog = NavigateToItemUpdateCallLog(callCount: 0, itemId: nil)
  
  func presentMore(_ viewController: UIViewController, model: ItemDisplay) {
    presentMoreCallLog.callCount  += 1
    presentMoreCallLog.model      = model
  }
  
  func navigateToCommunication(remoteUserId: String, itemId: String) {
    navigateToCommunicationCallLog.callCount     += 1
    navigateToCommunicationCallLog.remoteUserId  = remoteUserId
    navigateToCommunicationCallLog.itemId        = itemId
  }
  
  func navigateToItemUpdate(itemId: String) {
    navigateToItemUpdateCallLog.callCount += 1
    navigateToItemUpdateCallLog.itemId    = itemId
  }
}
