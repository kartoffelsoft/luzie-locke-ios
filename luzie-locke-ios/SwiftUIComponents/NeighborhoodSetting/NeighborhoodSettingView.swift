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
        HStack {
          Spacer()
          Button {
            viewModel.didTapMinus()
          } label: {
            Image(systemName: "minus")
              .font(Font.body.weight(.bold))
              .foregroundColor(CustomColors.secondaryColor)
          }.frame(width: 40, height: 40)
            .background(CustomColors.primaryColor)
            .clipShape(Circle())
          HStack {
            Text("Radius: ").foregroundColor(CustomColors.primaryColor)
              .frame(width: 90, height: 40, alignment: .center)
            Text(viewModel.currentRadiusText ?? "---").foregroundColor(CustomColors.tertiaryColor)
              .frame(width: 90, height: 40, alignment: .leading)
          }
          Button {
            viewModel.didTapPlus()
          } label: {
            Image(systemName: "plus")
              .font(Font.body.weight(.bold))
              .foregroundColor(CustomColors.secondaryColor)
          }.frame(width: 40, height: 40)
            .background(CustomColors.primaryColor)
            .clipShape(Circle())
          Spacer()
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
          .font(CustomFonts.body)
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
