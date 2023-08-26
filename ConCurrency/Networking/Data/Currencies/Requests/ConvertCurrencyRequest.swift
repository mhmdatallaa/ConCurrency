//
//  CurrencyConvertRequest.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

struct ConvertCurrencyRequest: NetworkingRequest {
    var path: String
    var headers: [String : String] = [:]
    var queryItems: [URLQueryItem]? = nil
}
