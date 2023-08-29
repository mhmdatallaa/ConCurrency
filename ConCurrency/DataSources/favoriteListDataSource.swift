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
        let identifier = Constants.cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FavoriteCell
        let currency = currencies[indexPath.row]
        cell.configureCellViews(currencyCode: currency.currencyCode, currencyName: "CURRENCY", imageURL: currency.flagURL)
        cell.selectionStyle = .none
        if let _ = favoriteCurrencies.firstIndex(of: currency) {
            cell.setImage(for: Constants.checkMark)
        }
        
        return cell
    }
    
}

private enum Constants {
    static let checkMark = "checkmark.circle.fill"
    static let cellIdentifier = "FavoriteCell"
}
