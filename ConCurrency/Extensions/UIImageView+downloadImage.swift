//
//  UIImage+downloadImage.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import UIKit

extension UIImageView {
    private func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data, error == nil,
                  let image = UIImage(data: data) else {
                LoggerManager.error(message: "Couldn't download image")
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = image
            }
        }
        .resume()
    }
    
    func download(from link: String) {
        guard let url = URL(string: link) else {
            LoggerManager.error(message: "Invalid URL")
            return
        }
        
        downloaded(from: url)
    }
}


