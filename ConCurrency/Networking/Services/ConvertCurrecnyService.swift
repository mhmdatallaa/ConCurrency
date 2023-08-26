//
//  ConvertCurrecnyServicing.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

protocol ConvertCurrecnyServicing {
    func fetchConvertCurrency(baseCurrency: String, targetCurrency: String, amount: String, completion: @escaping (Result<ConvertCurrencyResponse, Error>) -> ())
}

struct ConvertCurrencyService: ConvertCurrecnyServicing {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func fetchConvertCurrency(baseCurrency: String, targetCurrency: String, amount: String, completion: @escaping (Result<ConvertCurrencyResponse, Error>) -> ()) {
        let request = ConvertCurrencyRequest(path: "\(NetworkingConstants.currencyConversion)/\(baseCurrency)/\(targetCurrency)/\(amount)").buildURLRequest()
        
        LoggerManager.info(message: "\(String(describing: request.url))")
        
        client.perform(request) { (result: Result<ConvertCurrencyResponse, Error>) in
            let response: Result<ConvertCurrencyResponse, Error>
            defer { completion(response) }
            switch result {
            case .success(let convertCurrencyResponse):
                response = .success(convertCurrencyResponse)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
                response = .failure(error)
        }
    
        }
    }
}
