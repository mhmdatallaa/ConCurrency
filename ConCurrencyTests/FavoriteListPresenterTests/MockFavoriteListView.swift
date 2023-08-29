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
    var allCurrencies: [Currency]?

    var markFavoriteCurrenciesCalled = false
    var favoriteCurrencies: [Currency]?

    func getAllCurrencies(_ currencies: [Currency]) {
        getAllCurrenciesCalled = true
        allCurrencies = currencies
    }

    func markFavoriteCurrencies(_ currencies: [Currency]) {
        markFavoriteCurrenciesCalled = true
        favoriteCurrencies = currencies
    }
}
