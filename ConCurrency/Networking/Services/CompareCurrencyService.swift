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
        
        // Create the request body
        let requestBody = CurrencyConversionRequest(baseCode: baseCurrency, firstTargetCode: firstTarget, secondTargetCode: secondTarget, amount: amount)

        // Encode the request body to JSON data
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(requestBody) else {
            print("Error encoding request body")
            return
        }
        
        let headers =
        [
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Accept-Encoding": "gzip, deflate, br"
        ]
        
        let request = CompareCurrencyRequest(body: jsonData, headers: headers).buildURLRequest()
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
