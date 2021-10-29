//
//  Constant.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.10.21.
//

import UIKit

enum Images {
  static let avatarPlaceholder  = UIImage(named: "AvatarPlaceholder")
  
  static let listings           = UIImage(named: "List")
  
  static let purchases          = UIImage(named: "ShoppingBag")
  
  static let favorites          = UIImage(named: "FavoriteList")
  
  static let location           = UIImage(systemName: "location",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .thin))
  
  static let logout             = UIImage(systemName: "lock",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .thin))
  
  static let home               = UIImage(systemName: "house",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
  
  static let search             = UIImage(systemName: "magnifyingglass",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
  
  static let chats              = UIImage(systemName: "message",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
  
  static let settings           = UIImage(systemName: "gearshape",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
  
  static let floatingAdd        = UIImage(systemName: "plus",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))?
                                    .withTintColor(Colors.secondaryColor, renderingMode: .alwaysOriginal)
  
  static let selectDisabled     = UIImage(systemName: "lock",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
  
  static let selectEnabled      = UIImage(systemName: "photo",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))?
                                    .withTintColor(UIColor(named: "PrimaryColor")!, renderingMode: .alwaysOriginal)
  
  static let upload             = UIImage(systemName: "icloud.and.arrow.up",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?
                                    .withTintColor(Colors.primaryColor, renderingMode: .alwaysOriginal)
}

enum Colors {
  static let primaryColor       = UIColor(named: "PrimaryColor")!
  static let primaryColorLight1 = UIColor(named: "PrimaryColorLight1")!
  static let primaryColorLight2 = UIColor(named: "PrimaryColorLight2")!
  static let primaryColorLight3 = UIColor(named: "PrimaryColorLight3")!
  static let primaryColorDark1  = UIColor(named: "PrimaryColorDark1")!
  static let primaryColorDark2  = UIColor(named: "PrimaryColorDark2")!
  static let secondaryColor     = UIColor(named: "SecondaryColor")!
}

enum Fonts {
  static let title      = UIFont(name: "SuperCell-Magic", size: 14)!
  static let subtitle   = UIFont(name: "SuperCell-Magic", size: 12)!
  static let body       = UIFont(name: "SuperCell-Magic", size: 10)!
  static let caption    = UIFont(name: "SuperCell-Magic", size: 8)!
}
