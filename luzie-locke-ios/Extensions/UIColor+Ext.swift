//
//  UIColor+Ext.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.01.22.
//

import UIKit

extension UIColor {
  
  static let custom = CustomUIColor()
}

struct CustomUIColor {
  
  let primaryColor       = UIColor(named: "PrimaryColor")!
  let primaryColorLight1 = UIColor(named: "PrimaryColorLight1")!
  let primaryColorLight2 = UIColor(named: "PrimaryColorLight2")!
  let primaryColorLight3 = UIColor(named: "PrimaryColorLight3")!
  let primaryColorDark1  = UIColor(named: "PrimaryColorDark1")!
  let primaryColorDark2  = UIColor(named: "PrimaryColorDark2")!
  let secondaryColor     = UIColor(named: "SecondaryColor")!
  let tertiaryColor      = UIColor(named: "TertiaryColor")!
}
