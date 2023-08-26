//
//  PersistingManager.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import Foundation

enum PersistingActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Currency, actionType: PersistingActionType, completion: @escaping (PersistingError?) -> ()) {
        retrieveFavorites { result in
            switch result {
            case .success(let currencies):
                var retrievedCurrencies = currencies
                switch actionType {
                case .add:
                    guard !retrievedCurrencies.contains(favorite) else {
                        return
                    }
                    retrievedCurrencies.append(favorite)
                case .remove:
                    LoggerManager.info(message: "\(retrievedCurrencies)")
                    retrievedCurrencies.removeAll { $0.currencyCode == favorite.currencyCode}
                }
                LoggerManager.info(message: "RETRIVED: \(retrievedCurrencies)")
                completion(save(favorites: retrievedCurrencies))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func save(favorites: [Currency]) -> PersistingError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            LoggerManager.error(message: PersistingError.unableToFavorite.localizedDescription)
            return .unableToFavorite
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Currency], PersistingError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            LoggerManager.info(message: "Empty favorties array")
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Currency].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            LoggerManager.error(message: "Unable to decode favorite currencies")
            completion(.failure(.unableToFavorite))
        }
    }
}
