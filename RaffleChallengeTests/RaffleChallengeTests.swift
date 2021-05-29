//
//  RaffleChallengeTests.swift
//  RaffleChallengeTests
//
//  Created by Gregory Keeley on 5/28/21.
//

import XCTest
@testable import RaffleChallenge

class RaffleChallengeTests: XCTestCase {
    
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
}
