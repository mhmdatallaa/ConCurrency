//
//  CurrencyExchangeRateResponse.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

// MARK: - CurrencyExchangeRateResponse

struct CurrencyExchangeRateResponse: Decodable {
    let status: String
    let data: [ExchageRate]
}

// MARK: - ExchageRateData

struct ExchageRate: Codable {
    let code: String
    let rate: Double
//
//    enum CodingKeys: String, CodingKey {
////        case baseCode = "base_code"
//        case conversionRates = "conversion_rates"
//    }
}
