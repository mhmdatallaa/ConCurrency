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

struct CompareData: Codable {
    let baseCode: String
    let conversionRates: ConversionRates

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}

// MARK: - ConversionRates

struct ConversionRates: Codable {
    let firstTargetRate, secondTargetRate: Double

    enum CodingKeys: String, CodingKey {
        case firstTargetRate = "FirstTargetRate"
        case secondTargetRate = "SecondTargetRate"
    }
}
