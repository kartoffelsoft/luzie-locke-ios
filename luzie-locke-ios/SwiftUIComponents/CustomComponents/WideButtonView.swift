//
//  WideButtonView.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.01.22.
//

import SwiftUI

struct WideButtonView: View {
  
  let text: String
  
  var body: some View {
    HStack {
      Spacer()
      VStack(alignment: .center) {
        Text(text).font(CustomFonts.body).foregroundColor(Color.custom.secondaryColor)
      }.padding()
      Spacer()
    }
    .background(Color.custom.primaryColor)
    .cornerRadius(15)
  }
}

struct WideButtonView_Previews: PreviewProvider {
  
  static var previews: some View {
    WideButtonView(text: "APPLY")
      .previewLayout(.sizeThatFits)
  }
}
