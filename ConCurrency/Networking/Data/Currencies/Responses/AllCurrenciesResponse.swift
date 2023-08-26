//
//  AllCurrencyListResponse.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

// MARK: - AllCurrenciesResponse

struct AllCurrenciesResponse: Decodable {
    let status: String
    let data: [Currency]
}

// MARK: - Currency

struct Currency: Decodable {
    let name: String
    let currencyCode: String
    let flagURL: String
}
