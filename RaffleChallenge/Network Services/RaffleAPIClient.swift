//
//  RaffleAPIClient.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/28/21.
//

import Foundation

class RaffleAPIClient {
    
    // Fetches a list of all raffles available on API
    static func fetchAllRaffles(completion: @escaping (Result<[Raffle], AppError>) -> ()) {
        let endpoint = "https://raffle-fs-app.herokuapp.com/api/raffles"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let raffles = try JSONDecoder().decode([Raffle].self, from: data)
                    completion(.success(raffles))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    
    // Retrieves a single raffle by "ID"
    static func fetchRaffle(raffleID: Int, completion: @escaping (Result<Raffle, AppError>) -> ()) {
        let endpoint = "https://raffle-fs-app.herokuapp.com/api/raffles/\(raffleID)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let raffle = try JSONDecoder().decode(Raffle.self, from: data)
                    completion(.success(raffle))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    // Create a raffle
    /// Uses a POST request
    static func createRaffle(name: String, secretToken: String, completion: @escaping (Result<Bool, AppError>) -> ()) {
        let parameters = "{\n\t\"name\": \"\(name)\",\n\t\"secret_token\": \"\(secretToken)\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://raffle-fs-app.herokuapp.com/api/raffles")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case.success:
                completion(.success(true))
            }
        }
    }
    
    // Fetches a list of all participants for a raffle, using the raffle ID
    static func fetchParticipantsForRaffle(raffleID: Int, completion: @escaping (Result<[Participant], AppError>) -> ()) {
        let endpoint = "https://raffle-fs-app.herokuapp.com/api/raffles/\(raffleID)/participants"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let participants = try JSONDecoder().decode([Participant].self, from: data)
                    completion(.success(participants))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    
    // Signs up participant to a raffle
    ///
    /// Uses a POST request
    static func addParticipantToRaffle(name: String, email: String, phone: String?, raffleID: Int) {
        //        var endpoint = "https://raffle-fs-app.herokuapp.com/api/raffles/\(raffleID)/participants"
    }
    
    // Returns a winner from all participants that signed up for a given raffle
    /// User must enter the same secret key used when creating the raffle
    /// Uses a PUT request
    static func selectRaffleWinner(secret: String, raffleID: Int) {
        //        var endpoint = "https://raffle-fs-app.herokuapp.com/api/raffles/\(raffleID)/winner/"
    }
}
