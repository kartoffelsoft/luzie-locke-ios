//
//  Constant.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.10.21.
//

import UIKit

enum Images {
  static let avatarPlaceholder  = UIImage(named: "AvatarPlaceholder")
  
  static let mainLogo           = UIImage(named: "Logo")
  
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
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?
                                    .withTintColor(Colors.primaryColor, renderingMode: .alwaysOriginal)
  
  static let chats              = UIImage(systemName: "message",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
  
  static let settings           = UIImage(systemName: "gearshape",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
  
  static let floatingAdd        = UIImage(systemName: "plus",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))?
                                    .withTintColor(Colors.secondaryColor, renderingMode: .alwaysOriginal)
  
  static let imageAdd           = UIImage(named: "ImageAdd")
  
  static let upload             = UIImage(systemName: "icloud.and.arrow.up",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?
                                    .withTintColor(Colors.primaryColor, renderingMode: .alwaysOriginal)
  
  static let favoriteOff        = UIImage(systemName: "heart",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .medium))?
                                    .withTintColor(Colors.primaryColorLight3, renderingMode: .alwaysOriginal)
  
  static let favoriteOn         = UIImage(systemName: "heart.fill",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .medium))?
                                    .withTintColor(Colors.secondaryColor, renderingMode: .alwaysOriginal)
  
  static let chevronUp          = UIImage(systemName: "chevron.up",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))?
                                    .withTintColor(Colors.primaryColor, renderingMode: .alwaysOriginal)
  
  static let chevronDown        = UIImage(systemName: "chevron.down",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))?
                                    .withTintColor(Colors.primaryColor, renderingMode: .alwaysOriginal)
  
  static let menuItemArrow      = UIImage(systemName: "chevron.compact.right",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))?
                                    .withTintColor(Colors.primaryColor, renderingMode: .alwaysOriginal)
  
  static let messageSend        = UIImage(systemName: "paperplane.circle",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))?
                                    .withTintColor(Colors.secondaryColor, renderingMode: .alwaysOriginal)
  
  static let delete             = UIImage(systemName: "trash",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .bold))?
                                    .withTintColor(Colors.secondaryColor, renderingMode: .alwaysOriginal)
  
  static let itemEdit           = UIImage(systemName: "pencil.circle",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .medium))?
                                    .withTintColor(Colors.secondaryColor, renderingMode: .alwaysOriginal)
  
  static let itemDelete         = UIImage(systemName: "trash.circle",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .medium))?
                                    .withTintColor(Colors.secondaryColor, renderingMode: .alwaysOriginal)
  
  static let cross              = UIImage(systemName: "xmark.circle",
                                          withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?
                                    .withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
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
  static let titleLarge = UIFont(name: "SuperCell-Magic", size: 20)!
  static let title      = UIFont(name: "SuperCell-Magic", size: 16)!
  static let subtitle   = UIFont(name: "SuperCell-Magic", size: 13)!
  static let body       = UIFont(name: "SuperCell-Magic", size: 11)!
  static let caption    = UIFont(name: "SuperCell-Magic", size: 9)!
  static let detail     = UIFont(name: "SuperCell-Magic", size: 8)!
}
