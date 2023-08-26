//
//  CurrencyExchangeRateResponse.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import Foundation

protocol CurrencyExchangeRateServicing {
    func fetchCurrencyExchangeRate(baseCurrency: String, completion: @escaping (Result<CurrencyExchangeRateResponse, Error>) -> Void)
}

struct CurrencyExchangeRateService: CurrencyExchangeRateServicing {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func fetchCurrencyExchangeRate(baseCurrency: String, completion: @escaping (Result<CurrencyExchangeRateResponse, Error>) -> Void) {
        let request = CurrencyExchangeRateRequest(path: "\(NetworkingConstants.currencyExchangeRate)/\(baseCurrency)").buildURLRequest()
        
        LoggerManager.info(message: "\(String(describing: request.url))")
        
        client.perform(request) { (result: Result<CurrencyExchangeRateResponse, Error>) in
            let response: Result<CurrencyExchangeRateResponse, Error>
            defer { completion(response) }
            switch result {
            case .success(let currencyExchangeRateResponse):
                response = .success(currencyExchangeRateResponse)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
                response = .failure(error)
            }
        }
    }
}
