//
//  FavoriteListPresenter.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 27/08/2023.
//

import Foundation

protocol BaseView: AnyObject {
    
}

final class FavoriteListPresenter {
    
    weak var view: BaseView?
    weak var delegate: CurrencyFavoritingDelegate?
//    var currencies = [Currency]()

    
    init(view: BaseView) {
        self.view = view
//        fetchAllCurrencies()
    }
    
//    private func fetchAllCurrencies() {
//        NetworkingManager.shared.fetchAllCurrencies { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let allCurrencies):
//                self.currencies = allCurrencies.data
//            case .failure(let error):
//                LoggerManager.error(message: error.localizedDescription)
//            }
//        }
//    }
    
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
    

