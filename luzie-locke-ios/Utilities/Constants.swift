//
//  Constant.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.10.21.
//

import UIKit

enum Images {
  static let avatarPlaceholder    = UIImage(named: "AvatarPlaceholder")
  
  static let listings             = UIImage(
                                      systemName: "line.horizontal.3.circle",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .thin))
  
  static let purchases            = UIImage(
                                      systemName: "bag.circle",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .thin))
  
  static let favorites            = UIImage(
                                      systemName: "heart.circle",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .thin))
  
  static let location             = UIImage(
                                      systemName: "location",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .thin))
  
  static let logout               = UIImage(
                                      systemName: "lock",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .thin))
  
  static let home                 = UIImage(
                                      systemName: "house",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
  
  static let search               = UIImage(
                                      systemName: "magnifyingglass",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
  
  static let chats                = UIImage(
                                      systemName: "message",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
  
  static let settings             = UIImage(
                                      systemName: "person",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
}
