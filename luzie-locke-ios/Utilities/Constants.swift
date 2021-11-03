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
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?
                                    .withTintColor(Colors.tertiaryColor, renderingMode: .alwaysOriginal)
  
  static let logout             = UIImage(systemName: "lock",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?
                                    .withTintColor(Colors.tertiaryColor, renderingMode: .alwaysOriginal)
  
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
  
  static let selectImage        = UIImage(systemName: "photo",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))?
                                    .withTintColor(Colors.primaryColorLight1, renderingMode: .alwaysOriginal)
  
  static let upload             = UIImage(systemName: "icloud.and.arrow.up",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?
                                    .withTintColor(Colors.primaryColor, renderingMode: .alwaysOriginal)
  
  static let favoriteOff        = UIImage(systemName: "heart",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .medium))?
                                    .withTintColor(Colors.primaryColorLight3, renderingMode: .alwaysOriginal)
  
  static let favoriteOn         = UIImage(systemName: "heart.fill",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .medium))?
                                    .withTintColor(Colors.secondaryColor, renderingMode: .alwaysOriginal)
  
  static let chevronUp         = UIImage(systemName: "chevron.up",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))?
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
  static let tertiaryColor      = UIColor(named: "TertiaryColor")!
}

enum Fonts {
  static let titleLarge = UIFont(name: "SuperCell-Magic", size: 22)!
  static let title      = UIFont(name: "SuperCell-Magic", size: 14)!
  static let subtitle   = UIFont(name: "SuperCell-Magic", size: 12)!
  static let body       = UIFont(name: "SuperCell-Magic", size: 10)!
  static let caption    = UIFont(name: "SuperCell-Magic", size: 8)!
}
