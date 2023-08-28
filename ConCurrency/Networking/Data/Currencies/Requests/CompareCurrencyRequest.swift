//
//  CurrencyCompareRequest.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

struct CompareCurrencyRequest: NetworkingRequest {
    var path: String = NetworkingConstants.currencyCompare
    var method: HTTPMethod = .POST
    var body: Data?
    var headers: [String : String]
    var queryItems: [URLQueryItem]? = nil
}

// MARK: CurrencyCompareRequest Body

struct CurrencyConversionRequest: Codable {
    let baseCode: String
    let firstTargetCode: String
    let secondTargetCode: String
    let amount: Double
}
