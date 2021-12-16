//
//  PopCoordinatable.swift
//  luzie-locke-ios
//
//  Created by Harry on 16.12.21.
//

import Foundation

protocol PopCoordinatable: AnyObject {
  
  func popViewController()
  func popToRootViewController() 
}
