//
//  NetworkingError.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

enum NetworkError: Error {
    case noData
    case networkError
}

extension NetworkError {
    var errorDescription: String {
        switch self {
        case .noData:
            return NSLocalizedString(
                "The resource you requested could not be found.",
                comment: "No Data")
        case .networkError:
            return NSLocalizedString(
                "Generic Network Error.",
                comment: "Network Error")
        }
    }
}
