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
            Text(viewModel.currentLocation ?? "---").foregroundColor(CustomColors.tertiaryColor)
              .frame(width: 300, height: 40, alignment: .center)
              .font(CustomFonts.body)
          }
          Spacer()
        }
        HStack {
          Button {
            viewModel.didTapApply()
          } label: {
            HStack {
              Spacer()
              VStack(alignment: .center) {
                Text("APPLY").font(CustomFonts.body).foregroundColor(CustomColors.secondaryColor)
              }.padding()
              Spacer()
            }
            .background(CustomColors.primaryColor)
            .cornerRadius(15)
          }
        }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
      }
    }
  }
}
