//
//  UIView+roundCorner.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit

extension UIView {
    func roundCorner() {
        layer.cornerRadius = frame.height/2
        layer.borderWidth = 0.3
        layer.masksToBounds = true
    }
}
