//
//  CompareCurrencyService.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import Foundation

protocol CompareCurrecnyServicing {
    func fetchCompareCurrency(baseCurrency: String, firstTarget: String, secondTarget: String, amount: Double, completion: @escaping (Result<CompareCurrencyResponse, Error>) -> ())
}

struct CompareCurrencyService: CompareCurrecnyServicing {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func fetchCompareCurrency(baseCurrency: String, firstTarget: String, secondTarget: String, amount: Double, completion: @escaping (Result<CompareCurrencyResponse, Error>) -> ()) {
        let bodyData = """
        {
            "baseCode": \(baseCurrency),
            "firstTargetCode": \(firstTarget),
            "secondTargetCode": \(secondTarget),
            "amount": \(amount)
        }
        """.data(using: .utf8)
        
        let request = CompareCurrencyRequest(body: bodyData).buildURLRequest()
        LoggerManager.info(message: "url: \(String(describing: request.url)) body: \(String(describing: request.httpBody))")
        
        client.perform(request) { (result: Result<CompareCurrencyResponse, Error>) in
            let response: Result<CompareCurrencyResponse, Error>
            defer { completion(response) }
            switch result {
            case .success(let compareCurrencyResponse):
                response = .success(compareCurrencyResponse)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
                response = .failure(error)
            }
        }
    }
}
