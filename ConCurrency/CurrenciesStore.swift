////
////  CurrenciesStore.swift
////  ConCurrency
////
////  Created by Mohamed Atallah on 27/08/2023.
////
//
import Foundation

protocol Networking {
    func fetchAllCurrencies(completion: @escaping (Result<AllCurrenciesResponse, Error>) -> Void)
    func fetchConvertCurrency(baseCurrency: String, targetCurrency: String, amount: String, completion: @escaping (Result<ConvertCurrencyResponse, Error>) -> ())
    func fetchCompareCurrency(baseCurrency: String, firstTarget: String, secondTarget: String, amount: Double, completion: @escaping (Result<CompareCurrencyResponse, Error>) -> ())
    func fetchCurrencyExchangeRate(baseCurrency: String, completion: @escaping (Result<CurrencyExchangeRateResponse, Error>) -> Void)
}

class NetworkingManager: Networking {
    static let shared = NetworkingManager()
    private let client = URLSessionClient()
    
    private init () { }
    
    func fetchAllCurrencies(completion: @escaping (Result<AllCurrenciesResponse, Error>) -> Void) {
        let service = CurrenciesListService(client: client)
        service.fetchAllCurrencies { result in
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
    
    func fetchConvertCurrency(baseCurrency: String, targetCurrency: String, amount: String, completion: @escaping (Result<ConvertCurrencyResponse, Error>) -> ()) {
        let service = ConvertCurrencyService(client: client)
        service.fetchConvertCurrency(baseCurrency: baseCurrency, targetCurrency: targetCurrency, amount: amount) { result in
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
    
    
    func fetchCompareCurrency(baseCurrency: String, firstTarget: String, secondTarget: String, amount: Double, completion: @escaping (Result<CompareCurrencyResponse, Error>) -> ()) {
        let service = CompareCurrencyService(client: client)
        service.fetchCompareCurrency(baseCurrency: baseCurrency, firstTarget: firstTarget, secondTarget: secondTarget, amount: amount) { result in
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
    
    func fetchCurrencyExchangeRate(baseCurrency: String, completion: @escaping (Result<CurrencyExchangeRateResponse, Error>) -> Void) {
        let service = CurrencyExchangeRateService(client: client)
        service.fetchCurrencyExchangeRate(baseCurrency: baseCurrency) { result in
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
