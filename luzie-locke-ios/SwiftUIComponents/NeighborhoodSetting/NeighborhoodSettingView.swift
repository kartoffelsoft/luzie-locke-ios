//
//  NeighborhoodSettingView.swift
//  luzie-locke-ios
//
//  Created by Harry on 04.12.21.
//

import SwiftUI
import MapKit

struct NeighborhoodSettingView: View {
  
  @EnvironmentObject var viewModel: NeighborhoodSettingViewModel
  
  var body: some View {
    ZStack(alignment: .top) {

      VStack {
        NeighborhoodSettingMap().edgesIgnoringSafeArea(.all)
        radiusControl
        applyButton
      }
    }
  }
}

extension NeighborhoodSettingView {
  
  private var radiusControl: some View {
    HStack {
      Spacer()
      CircleButtonView(iconName: "minus", radius: 40)
        .onTapGesture { viewModel.didTapMinus() }
      HStack {
        Text("Radius: ").foregroundColor(CustomColors.primaryColor)
          .frame(width: 90, height: 40, alignment: .center)
        Text(viewModel.currentRadiusText ?? "---").foregroundColor(CustomColors.tertiaryColor)
          .frame(width: 90, height: 40, alignment: .leading)
      }
      CircleButtonView(iconName: "plus", radius: 40)
        .onTapGesture { viewModel.didTapPlus() }
      Spacer()
    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
      .font(CustomFonts.body)
  }

  private var applyButton: some View {
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
