//
//  UIImageView+roundImage.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import UIKit

extension UIImageView {
    func roundImage() {
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
    }
}
