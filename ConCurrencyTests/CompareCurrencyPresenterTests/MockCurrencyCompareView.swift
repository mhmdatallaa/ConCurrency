//
//  MockCurrencyCompareView.swift
//  ConCurrencyTests
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import Foundation
@testable import ConCurrency

class MockCurrencyCompareViewProtocol: CurrencyCompareViewProtocol {

    var getAllCurrenciesCalled = false
    var allCurrencies: [Currency]?

    var updateResultCalled = false
    var target1: String?
    var target2: String?

    func getAllCurrencies(_ currencies: [Currency]) {
        getAllCurrenciesCalled = true
        allCurrencies = currencies
    }

    func updateResult(target1: String, target2: String) {
        updateResultCalled = true
        self.target1 = target1
        self.target2 = target2
    }
}
