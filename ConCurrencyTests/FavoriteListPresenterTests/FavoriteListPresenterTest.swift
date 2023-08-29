//
//  FavoriteListPresenterTest.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 29/08/2023.
//

import XCTest
@testable import ConCurrency

class FavoriteListPresenterTests: XCTestCase {
    
    // MARK: - Properties
    
    private var presenter: FavoriteListPresenter!
    private var mockView: MockFavoriteListView!
    private var delegate: MockDelegate!
    
    // MARK: Lif cycle
    
    override func setUp() {
        super.setUp()
        mockView = MockFavoriteListView()
        presenter = FavoriteListPresenter(view: mockView)
        delegate = MockDelegate()
        presenter.delegate = delegate
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        delegate = nil
        super.tearDown()
    }
    
    // MARK: tests
    
    func testAddToFavorite() {
        // Given
        let currency = Currency(name: "USD", currencyCode: "USD", flagURL: "https://url")
        
        // When
        presenter.addToFavorite(currency)
        
        // Then
        XCTAssertTrue(delegate.favoriteCurrencyCelled)
        XCTAssertEqual(delegate.favoriteCurrency, currency)
        XCTAssertEqual(delegate.actionType, .add)
    }
    
    func testRemoveFromFavorite() {
        // Given
        let currency = Currency(name: "USD", currencyCode: "USD", flagURL: "https://url")
        
        // When
        presenter.removeFromFavorite(currency)
        
        // Then
        XCTAssertTrue(delegate.favoriteCurrencyCelled)
        XCTAssertEqual(delegate.favoriteCurrency, currency)
        XCTAssertTrue(delegate.favoriteCurrencyCelled)
        XCTAssertEqual(delegate.actionType, .remove)
    }
}
