//
//  CurrencyComparePresenterTests.swift
//  ConCurrencyTests
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import XCTest
@testable import ConCurrency

class CurrencyComparePresenterTests: XCTestCase {
    
    // MARK: - Properties

    private var presenter: CurrencyComparePresenter!
    private var mockView: MockCurrencyCompareViewProtocol!
    
    // MARK: Lif cycle

    override func setUp() {
        super.setUp()
        mockView = MockCurrencyCompareViewProtocol()
        presenter = CurrencyComparePresenter(view: mockView)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        super.tearDown()
    }
    
    // MARK: - Tests


}


