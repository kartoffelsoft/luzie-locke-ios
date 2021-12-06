//
//  RadiusSettingView.swift
//  luzie-locke-ios
//
//  Created by Harry on 04.12.21.
//

import SwiftUI
import MapKit

struct NeighbourhoodSettingView: View {
  
  @EnvironmentObject var viewModel: NeighbourhoodSettingViewModel
  
  var body: some View {
    ZStack(alignment: .top) {
      NeighbourhoodSettingMap().edgesIgnoringSafeArea(.all)
      VStack {
        Spacer()
        HStack {
          Spacer()
          Button {
            viewModel.didTapMinus()
          } label: {
            Image(systemName: "minus")
              .font(Font.body.weight(.bold))
              .foregroundColor(Color(Colors.secondaryColor))
          }.frame(width: 40, height: 40)
            .background(Color(Colors.primaryColor))
            .clipShape(Circle())
          HStack {
            Text("Radius: ").foregroundColor(Color(Colors.tertiaryColor))
            Text(viewModel.currentRadiusText ?? "---").foregroundColor(Color(Colors.primaryColor))
          }.frame(width: 180, height: 40, alignment: .center)
            .background(Color.white)
            .cornerRadius(5)
          Button {
            viewModel.didTapPlus()
          } label: {
            Image(systemName: "plus")
              .font(Font.body.weight(.bold))
              .foregroundColor(Color(Colors.secondaryColor))
          }.frame(width: 40, height: 40)
            .background(Color(Colors.primaryColor))
            .clipShape(Circle())
          Spacer()
        }.font(Font(Fonts.body as CTFont))
          .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        HStack {
          Button {
            
          } label: {
            HStack {
              Spacer()
              VStack(alignment: .center) {
                Text("APPLY").font(Font(Fonts.body as CTFont)).foregroundColor(Color(Colors.secondaryColor))
              }.padding()
              Spacer()
            }
            .background(Color(Colors.primaryColor))
            .cornerRadius(15)
          }
        }.padding()
      }
    }
  }
}
