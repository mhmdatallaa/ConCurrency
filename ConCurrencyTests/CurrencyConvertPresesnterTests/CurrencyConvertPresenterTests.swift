//
//  test.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import XCTest
@testable import ConCurrency

final class CurrencyConvertPresenterTests: XCTestCase {
    
    // MARK: - Properties
    
    private var presenter: CurrencyConvertPresenter!
    private var mockView: MockCurrencyConvertView!
    
    // MARK: Lif cycle
    
    override func setUp() {
        super.setUp()
        mockView = MockCurrencyConvertView()
        presenter = CurrencyConvertPresenter(view: mockView)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
}
