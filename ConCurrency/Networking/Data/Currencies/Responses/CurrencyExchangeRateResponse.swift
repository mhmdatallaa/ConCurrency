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
    let data: ExchageRateData
}

// MARK: - ExchageRateData

struct ExchageRateData: Codable {
//    let baseCode: String
    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
//        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}
