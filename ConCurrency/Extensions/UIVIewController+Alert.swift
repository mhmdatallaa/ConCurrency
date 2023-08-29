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
    
    func showToast(message: String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(
            x: view.frame.size.width/2 - 75,
            y: view.frame.size.height - 100,
            width: 170,
            height: 35))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
        
    }
    
    func toastMessage(action: ActionType) {
        switch action {
        case .add:
            showToast(message: "✅ Added to favorites", font: UIFont.systemFont(ofSize: 12))
        case .remove:
            showToast(message: "❌ Removed from favorites", font: UIFont.systemFont(ofSize: 12))
        }
    }
}

