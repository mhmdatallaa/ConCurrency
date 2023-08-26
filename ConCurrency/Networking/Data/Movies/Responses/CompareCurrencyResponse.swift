//
//  CompareCurrencyResponse.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

// MARK: - CompareCurrencyResponse

struct CompareCurrencyResponse: Decodable {
    let status: String
    let data: CompareData
}

// MARK: - CompareData

struct CompareData: Decodable {
    let baseCurrency: String
    let conversionRates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
         case baseCurrency = "base_code"
         case conversionRates = "conversion_rates"
     }
}
