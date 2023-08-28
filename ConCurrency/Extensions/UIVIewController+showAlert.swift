//
//  UIVIewController+showAlert.swift
//  ConCurrency
//
//  Created by manar on 27/08/2023.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        self.present(alert, animated: true)
    }
}
