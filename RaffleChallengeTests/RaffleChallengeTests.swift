//
//  RaffleChallengeTests.swift
//  RaffleChallengeTests
//
//  Created by Gregory Keeley on 5/28/21.
//

import XCTest
@testable import RaffleChallenge

class RaffleChallengeTests: XCTestCase {
    
    //MARK:- Model Tests
    func testRaffleModel() {
        let jsonData = """
            {
                "id": 8,
                "name": "My first Raffle",
                "created_at": "2021-05-28T14:50:27.189Z",
                "raffled_at": null,
                "winner_id": null
            }
            """.data(using: .utf8)!
        
        let expectedID = 8
        do {
            let results = try JSONDecoder().decode(Raffle.self, from: jsonData)
            let id = results.id
            XCTAssertEqual(expectedID, id)
        } catch {
            XCTFail("Decoding error: \(error)")
        }
    }
    func testParticipantModel() {
        let jsonData = """
                {
                    "id": 94,
                    "raffle_id": 37,
                    "firstname": "Jane",
                    "lastname": "Doe",
                    "email": "jane@jane.com",
                    "phone": "+1 (917) 555-1234",
                    "registered_at": "2021-05-29T12:37:43.838Z"
                }
            """.data(using: .utf8)!
        let expectedFirstName = "Jane"
        do {
            let results = try JSONDecoder().decode(Participant.self, from: jsonData)
            let firstName = results.firstName
            XCTAssertEqual(expectedFirstName, firstName)
        } catch {
            XCTFail("Decoding Error: \(error)")
        }
    }
    
    //MARK:- APIClient Tests
    func testFetchAllRaffles() {
        var raffles = [Raffle]()
        RaffleAPIClient.fetchAllRaffles { (results) in
            switch results {
            case .failure(let appError):
                XCTFail("Failed to fetch raffles: \(appError)")
            case .success(let data):
                raffles = data
                XCTAssertGreaterThan(0, raffles.count)
            }
        }
    }
    
    func testFetchRaffle() {
        var raffle: Raffle?
        RaffleAPIClient.fetchRaffle(raffleID: 37) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("Failed to fetch raffle: \(appError)")
            case .success(let data):
                raffle = data
                XCTAssertNotNil(raffle)
            }
        }
    }
    
    func testFetchParticipants() {
        var participants = [Participant]()
        
        // Using raffle id "37" here knowing it has participants. This test may fail in the future if this raffle no longer exists
        RaffleAPIClient.fetchParticipantsForRaffle(raffleID: 37) { (results) in
            switch results {
            case .failure(let appError):
                XCTFail("Failed to fetch participants: \(appError)")
            case .success(let data):
                participants = data
                XCTAssertGreaterThan(1, participants.count)
            } 
        }
    }
    
//    func testCreateRaffle() {
//        let raffleName = "Rain"
//        let raffleSecretToken = "gk123"
//        let exp = XCTestExpectation(description: "Raffle posted successfully")
//        RaffleAPIClient.createRaffle(name: raffleName, secretToken: raffleSecretToken) { (result) in
//            switch result {
//            case .failure(let appError):
//                XCTFail("Failed to create new raffle: \(appError)")
//            case .success(let data):
//                XCTAssertTrue(data)
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 15.0)
//    }
    
//    func testAddParticipantToRaffle() {
//        let firstName = "George"
//        let lastName = "Glass"
//        let email = "george@gmail.com"
//        let phone = "(555)555-5555"
//        let exp = XCTestExpectation(description: "Participant successfully added to raffle")
//        RaffleAPIClient.addParticipantToRaffle(firstName: firstName, lastName: lastName, email: email, phone: phone, raffleID: 150) { (result) in
//            switch result {
//            case .failure(let appError):
//                XCTFail("Failed to add participant to raffle: \(appError)")
//            case .success(let data):
//                XCTAssertTrue(data)
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 15.0)
//    }
//    func testSelectWinnerFromRaffle() {
//        let secretToken = "gk123"
//        let raffleID = 150
//        let exp = XCTestExpectation(description: "Winner has been selected")
//        RaffleAPIClient.selectRaffleWinner(secret: secretToken, raffleID: raffleID) { (result) in
//            switch result {
//            case .failure(let appError):
//                XCTFail("Failed to select a winner: \(appError)")
//            case .success(let data):
//                XCTAssertTrue(data)
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 15.0)
//    }
}
