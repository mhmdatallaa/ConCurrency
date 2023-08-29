//
//  ProtofolioCellDataSource.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import UIKit

class ProtofolioDataSource: NSObject, UITableViewDataSource {
    
    var favoriteCurrencies: [Currency] = []
    var exchangeRates: [ExchageRate] = []
    
    func updateFavoriteCurrencies(_ currency: Currency, action: ActionType) {
        switch action {
        case .add:
            favoriteCurrencies.append(currency)
        case .remove:
            favoriteCurrencies.removeAll { $0.currencyCode == currency.currencyCode }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ProtofolioCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ProtofolioCell
        let currency = favoriteCurrencies[indexPath.row]
        
        for exchangeRate in exchangeRates {
            if exchangeRate.code == currency.currencyCode {
                cell.exchangeRateLabel.text = "\(exchangeRate.rate)"

            }
        }
        cell.configureCellViews(currencyName: currency.name, imageURL: currency.flagURL)
        return cell
    }
    
}
