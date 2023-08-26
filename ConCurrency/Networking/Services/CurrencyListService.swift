//
//  CurrencyListService.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import Foundation

protocol CurreciesListServicing {
    func fetchAllCurrencies(completion: @escaping (Result<AllCurrenciesResponse, Error>) -> Void)
}

struct CurrenciesListService: CurreciesListServicing {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func fetchAllCurrencies(completion: @escaping (Result<AllCurrenciesResponse, Error>) -> Void) {
        let request = CurrencyListRequest().buildURLRequest()
        
        LoggerManager.info(message: "\(String(describing: request.url))")
        
        client.perform(request) { (result: Result<AllCurrenciesResponse, Error>) in
            let response: Result<AllCurrenciesResponse, Error>
            defer { completion(response) }
            switch result {
            case .success(let currencyListResponse):
                response = .success(currencyListResponse)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
                response = .failure(error)
            }
        }
    }
}
