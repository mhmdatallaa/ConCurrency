//
//  PersistingManagerProtocol.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 28/08/2023.
//

import Foundation

protocol PersistingManagerProtocol {
    static func updateWith(favorite: Currency, actionType: PersistingActionType, completion: @escaping (PersistingError?) -> ())
    static func save(favorites: [Currency]) -> PersistingError?
    static func retrieveFavorites(completion: @escaping (Result<[Currency], PersistingError>) -> Void)
}
