//
//  CurrencyConvertPresenter.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 28/08/2023.
//

import Foundation

protocol CurrencyConvertViewProtocol: AnyObject {
    func getAllCurrencies(_ currencies: [Currency])
    func updateConversionRate(_ rates: [ExchageRate])
    func updateResult(_ result: String)
    func showFavoriteCurrencies(_ currencies: [Currency])
    func showErrorAlert()
}

class CurrencyConvertPresenter {
    
    private weak var view: CurrencyConvertViewProtocol?
    private let client = URLSessionClient()
    private lazy var convertService = ConvertCurrencyService(client: client)
    private lazy var exchangeRatesServic = CurrencyExchangeRateService(client: client)
    private lazy var allCurrenciesService = CurrenciesListService(client: client)

    // MARK: Init

    init(view: CurrencyConvertViewProtocol) {
        self.view = view
    }
    
    func fetchConversionRates(for currency: String) {
        exchangeRatesServic.fetchCurrencyExchangeRate(baseCurrency: currency) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let rates = response.data
                self.view?.updateConversionRate(rates)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
                self.view?.showErrorAlert()
            }
        }
    }
    
    func convert(amount: String, from: String, to: String) {
        convertService.fetchConvertCurrency(baseCurrency: from, targetCurrency: to, amount: amount) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.view?.updateResult(response.data.conversionResult)
                //                self.resultAmountLabel.text = response.data.conversionResult
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
    func getFavoriteCurrencies() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let currencies):
                self.view?.showFavoriteCurrencies(currencies)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
    func fetchAllCurrencies() {
        // TODO: Use allCurrencies service
        allCurrenciesService.fetchAllCurrencies { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let currencies):
                self.view?.getAllCurrencies(currencies.data)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
}
