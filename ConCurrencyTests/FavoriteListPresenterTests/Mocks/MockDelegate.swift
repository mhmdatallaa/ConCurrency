//
//  MockDelegate.swift
//  ConCurrencyTests
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import Foundation
@testable import ConCurrency

class MockDelegate: CurrencyFavoritingDelegate {
    var favoriteCurrencyCelled = false
    var favoriteCurrency: Currency?
    var actionType: ActionType?
    
    func favorite(currency: Currency, actionType: ActionType) {
        favoriteCurrencyCelled = true
        favoriteCurrency = currency
        self.actionType = actionType
    }
}
