//
//  CurrencyListRequest.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

struct CurrencyListRequest: NetworkingRequest {
    // TODO: update with the right path
    var path: String { "allCurrency.json" }
//    var path: String { NetworkingConstants.allCurrencies }
    var headers: [String : String] = [:]
    var queryItems: [URLQueryItem]? = nil
}
