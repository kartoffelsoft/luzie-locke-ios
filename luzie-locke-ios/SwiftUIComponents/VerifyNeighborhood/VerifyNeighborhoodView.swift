//
//  VerifyNeighborhoodView.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.12.21.
//

import SwiftUI
import MapKit

struct VerifyNeighborhoodView: View {
  
  @EnvironmentObject var viewModel: VerifyNeighborhoodViewModel
  
  var body: some View {
    ZStack(alignment: .top) {
      VStack {
        VerifyNeighborhoodMap().edgesIgnoringSafeArea(.all)
        HStack {
          Spacer()
          HStack {
            Text(viewModel.currentLocation ?? "---").foregroundColor(Color.custom.tertiaryColor)
              .frame(width: 300, height: 40, alignment: .center)
              .font(CustomFonts.body)
          }
          Spacer()
        }
        HStack {
          WideButtonView(text: "APPLY")
            .onTapGesture { viewModel.didTapApply() }
        }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
      }
    }
  }
}
