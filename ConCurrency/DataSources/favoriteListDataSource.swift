//
//  favoriteListDataSource.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import UIKit

class FavoriteListDataSource: NSObject, UITableViewDataSource {
    
    var currencies: [Currency] = []
    var favoriteCurrencies: [Currency] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "FavoriteCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FavoriteCell
        let currency = currencies[indexPath.row]
        cell.configureCellViews(name: currency.name, imageURL: currency.flagURL)
        cell.selectionStyle = .none
        if let _ = favoriteCurrencies.firstIndex(of: currency) {
            cell.setImage(for: "checkmark.circle.fill")
        }
        
        return cell
    }
    
}
