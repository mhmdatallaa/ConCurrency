//
//  MockCurrencyView.swift
//  ConCurrencyTests
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import Foundation
@testable import ConCurrency

class MockCurrencyConvertView: CurrencyConvertViewProtocol {
    
    var getAllCurrenciesCalled = false
    var allCurrencies: [Currency]?
    
    var updateConversionRateCalled = false
    var updatedRates: [ExchageRate]?
    
    var updateResultCalled = false
    var updatedResult: String?
    
    var showFavoriteCurrenciesCalled = false
    var favoriteCurrencies: [Currency]?
    
    var showErrorAlertCalled = false
    
    func getAllCurrencies(_ currencies: [Currency]) {
        getAllCurrenciesCalled = true
        allCurrencies = currencies
    }
    
    func updateConversionRate(_ rates: [ExchageRate]) {
        updateConversionRateCalled = true
        updatedRates = rates
    }
    
    func updateResult(_ result: String) {
        updateResultCalled = true
        updatedResult = result
    }
    
    func showFavoriteCurrencies(_ currencies: [Currency]) {
        showFavoriteCurrenciesCalled = true
        favoriteCurrencies = currencies
    }
    
    func showErrorAlert() {
        showErrorAlertCalled = true
    }
}
