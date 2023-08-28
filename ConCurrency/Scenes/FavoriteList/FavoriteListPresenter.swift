//
//  FavoriteListPresenter.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 27/08/2023.
//

import Foundation

protocol FavoriteListViewProtocol: AnyObject {
    func getAllCurrencies(_ currencies: [Currency])
    func markFavoriteCurrencies(_ currencies: [Currency])
}

final class FavoriteListPresenter {
    
    private weak var view: FavoriteListViewProtocol?
    private let client = URLSessionClient()
    private lazy var allCurrenciesService = CurrenciesListService(client: client)
    weak var delegate: CurrencyFavoritingDelegate?

    
    
    
    init(view: FavoriteListViewProtocol) {
        self.view = view
    }
    
    func fetchAllCurrencies() {
        // TODO: Use allCurrencies service
        allCurrenciesService.fetchAllCurrencies { result in
            switch result {
            case .success(let currencies):
                self.view?.getAllCurrencies(currencies.data)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
    func getFavoriteCurrencies() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let currencies):
                self.view?.markFavoriteCurrencies(currencies)
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
    /// Add Currency to Favorite List
    ///
    func addToFavorite(_ currency: Currency) {
        PersistenceManager.updateWith(favorite: currency, actionType: .add) { error in
            if let error = error {
                LoggerManager.error(message: error.localizedDescription)
                return
            }
        }
        delegate?.favorite(currency: currency, actionType: .add)
    }
    
    /// Remove Currency from Favorite List
    ///
    func removeFromFavorite(_ currency: Currency) {
        PersistenceManager.updateWith(favorite: currency, actionType: .remove) { error in
            if let error = error {
                LoggerManager.error(message: error.rawValue)
                return
            }
        }
        delegate?.favorite(currency: currency, actionType: .remove)
    }
}
    

