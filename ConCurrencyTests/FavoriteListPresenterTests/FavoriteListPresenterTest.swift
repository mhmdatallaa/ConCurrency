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
    
    // MARK: Lif cycle
    
    override func setUp() {
        super.setUp()
        mockView = MockFavoriteListView()
        presenter = FavoriteListPresenter(view: mockView)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        //        mockDelegate = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
}
