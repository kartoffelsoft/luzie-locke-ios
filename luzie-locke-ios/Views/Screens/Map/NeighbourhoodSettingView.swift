//
//  RadiusSettingView.swift
//  luzie-locke-ios
//
//  Created by Harry on 04.12.21.
//

import SwiftUI

struct NeighbourhoodSettingView: View {
  var body: some View {
    ZStack(alignment: .top) {
      MapViewContainer().edgesIgnoringSafeArea(.all)
    }
  }
}

struct NeighbourhoodSettingView_Previews: PreviewProvider {
  static var previews: some View {
    NeighbourhoodSettingView()
  }
}
