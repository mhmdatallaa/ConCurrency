//
//  ConvertCurrencyResponse.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

// MARK: - ConvertCurrencyResponse

struct ConvertCurrencyResponse: Decodable {
    let status: String
    let data: ConvertData
}

// MARK: - ConvertData

struct ConvertData: Decodable {
    let baseCode, targetCode, conversionRate, conversionResult: String
}
