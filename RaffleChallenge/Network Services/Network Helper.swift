//
//  Network Services.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/28/21.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case badStatusCode(Int)
}

class NetworkHelper {
    static let shared = NetworkHelper()
    private var urlSession: URLSession
    private init() {
        urlSession = URLSession(configuration: .default)
    }
    public func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
