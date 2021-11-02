//
//  ItemActionPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemActionPanelViewModel {
  
  let bindablePriceText = Bindable<NSAttributedString>()

  var item: Item? {
    didSet {
      if let item = item, let price = item.price {
        let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: Fonts.title])
        priceText.append(NSAttributedString(string: price, attributes: [.font: Fonts.titleLarge]))
        bindablePriceText.value = priceText
      }
    }
  }
}
