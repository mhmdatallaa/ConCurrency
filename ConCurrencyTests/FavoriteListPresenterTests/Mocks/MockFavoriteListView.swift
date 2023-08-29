//
//  MockFavoriteListView.swift
//  ConCurrencyTests
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import Foundation
@testable import ConCurrency

class MockFavoriteListView: FavoriteListViewProtocol {

    var getAllCurrenciesCalled = false
    var markFavoriteCurrenciesCalled = false
    var getAllCurrencies: [Currency]?
    var markFavoriteCurrencies: [Currency]?

    func getAllCurrencies(_ currencies: [Currency]) {
        getAllCurrenciesCalled = true
        getAllCurrencies = currencies
    }

    func markFavoriteCurrencies(_ currencies: [Currency]) {
        markFavoriteCurrenciesCalled = true
        markFavoriteCurrencies = currencies
    }
}
