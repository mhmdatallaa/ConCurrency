//
//  CCLabel.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit

final class CCLabel: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = self.frame.height/2
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
    }
    
}
