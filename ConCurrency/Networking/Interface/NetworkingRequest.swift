//
//  NetworkingRequest.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

protocol NetworkingRequest {
    var method: HTTPMethod { get }
    var path : String { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    
    func buildURLRequest() -> URLRequest
}

extension NetworkingRequest {
    var method: HTTPMethod { .GET }
    var body: Data? { nil }
    
    func buildURLRequest() -> URLRequest {
        var urlCompnents = URLComponents(string: NetworkingConstants.baseURL)!
        if let queryItems = queryItems {
            urlCompnents.queryItems?.append(contentsOf: queryItems)
        }
        let baseURL = urlCompnents.url!
        let pathURL = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: pathURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        print(urlRequest.httpBody ?? "" )
        return urlRequest
    }
}
