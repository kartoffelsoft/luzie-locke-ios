//
//  NavigationHeaderLabel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import UIKit

class ScreenTitleLabel: UILabel {

    init(_ text: String) {
        super.init(frame: .zero)
        
        self.text = text
        textColor = UIColor.label
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
