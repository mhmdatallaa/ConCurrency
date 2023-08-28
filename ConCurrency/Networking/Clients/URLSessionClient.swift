//
//  URLSessionClient.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

final class URLSessionClient: HTTPClient {
    func perform<T: Decodable>(_ urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> ()) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            LoggerManager.info(message: "🌐 Request >>> \(urlRequest.url!.absoluteString)")
            let result: Result<T, Error>
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error {
                LoggerManager.error(message: "\(error.localizedDescription)")
                result = .failure(error)
                print(error.localizedDescription)
                return
            }
            
            guard let data else {
                result = .failure(NetworkError.noData)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    LoggerManager.info(message: " ✅ Status Code: 200")
                    break
                case 404, 422:
                    result = .failure(NetworkError.noData)
                    return
                default:
                    print(httpResponse.statusCode)
                    result = .failure(NetworkError.networkError)
                    return
                }
            }
            
            do {
                let response: T = try JSONDecoder().decode(T.self, from: data)
                LoggerManager.info(message: "🌐 Response >>> , \(response)")
                result = .success(response)
            } catch {
                LoggerManager.error(message: "\(error.localizedDescription)")
                result = .failure(error)
            }
        }
        .resume()
    }
}
