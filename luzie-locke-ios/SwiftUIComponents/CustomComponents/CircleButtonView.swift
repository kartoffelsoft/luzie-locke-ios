//
//  CircleButtonView.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.01.22.
//

import SwiftUI

struct CircleButtonView: View {
  
  let iconName: String
  let radius: CGFloat
  
  var body: some View {
    Image(systemName: iconName)
      .font(Font.body.weight(.bold))
      .foregroundColor(CustomColors.secondaryColor)
      .frame(width: radius, height: radius)
      .background(
        Circle()
          .foregroundColor(CustomColors.primaryColor)
      )
      .shadow(
        color: Color.black,
        radius: 0, x: 0, y: 0)
  }
}

struct CircleButtonView_Previews: PreviewProvider {
  
  static var previews: some View {
    CircleButtonView(iconName: "info", radius: 40)
      .previewLayout(.sizeThatFits)
  }
}
