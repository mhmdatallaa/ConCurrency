//
//  CurrencyComparePresenter.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 28/08/2023.
//

import Foundation

protocol CurrencyCompareViewProtocol: AnyObject {
    func getAllCurrencies(_ currencies: [Currency])
    func updateResult(target1: String, target2: String)
}

class CurrencyComparePresenter {
    
    private weak var view: CurrencyCompareViewProtocol?
    private let client = URLSessionClient()
    private lazy var compareService = CompareCurrencyService(client: client)
    private lazy var allCurrenciesService = CurrenciesListService(client: client)
    
    // MARK: Init
    
    init(view: CurrencyCompareViewProtocol) {
        self.view = view
    }
    
    func compare(baseCurrency: String, firstTarget: String, secondTarget: String, amount: Double) {
        compareService.fetchCompareCurrency(baseCurrency: baseCurrency, firstTarget: firstTarget, secondTarget: secondTarget, amount: amount) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let result1 = response.data.conversionRates.firstTargetRate
                let result2 = response.data.conversionRates.secondTargetRate
                self.view?.updateResult(target1: "\(result1)", target2: "\(result2)")
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
    func fetchAllCurrencies() {
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
