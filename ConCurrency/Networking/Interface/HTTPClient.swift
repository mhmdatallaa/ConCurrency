//
//  HTTPClient.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

protocol HTTPClient {
    func perform<T: Decodable>(_ urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> ())
}
