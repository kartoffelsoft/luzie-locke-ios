//
//  Color+Ext.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.01.22.
//

import SwiftUI

extension Color {
  
  static let custom = CustomColor()
}

struct CustomColor {
  
  let primaryColor       = Color("PrimaryColor")
  let primaryColorLight1 = Color("PrimaryColorLight1")
  let primaryColorLight2 = Color("PrimaryColorLight2")
  let primaryColorLight3 = Color("PrimaryColorLight3")
  let primaryColorDark1  = Color("PrimaryColorDark1")
  let primaryColorDark2  = Color("PrimaryColorDark2")
  let secondaryColor     = Color("SecondaryColor")
  let tertiaryColor      = Color("TertiaryColor")
}
