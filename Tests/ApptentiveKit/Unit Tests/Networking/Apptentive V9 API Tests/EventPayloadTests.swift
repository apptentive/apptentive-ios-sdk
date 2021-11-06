//
//  EventPayloadTests.swift
//  ApptentiveUnitTests
//
//  Created by Frank Schmitt on 10/19/20.
//  Copyright © 2020 Apptentive, Inc. All rights reserved.
//

import XCTest

@testable import ApptentiveKit

class EventPayloadTests: XCTestCase {
    func testEventEncoding() throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .secondsSince1970

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970

        let event: Event = "Foo bar"

        let eventPayload = Payload(wrapping: event)

        let encodedEventPayload = try jsonEncoder.encode(eventPayload)

        let expectedJSONString = """
            {
                "event": {
                    "nonce": "abc123",
                    "client_created_at": 1600904569,
                    "client_created_at_utc_offset": 0,
                    "label": "local#app#Foo bar"
                }
            }
            """

        let encodedExpectedJSON = expectedJSONString.data(using: .utf8)!

        let decodedExpectedJSON = try jsonDecoder.decode(Payload.self, from: encodedExpectedJSON)
        let decodedEventPayloadJSON = try jsonDecoder.decode(Payload.self, from: encodedEventPayload)

        XCTAssertEqual(decodedEventPayloadJSON.contents, decodedExpectedJSON.contents)

        XCTAssertNotNil(decodedEventPayloadJSON.nonce)
        XCTAssertNotNil(decodedEventPayloadJSON.creationDate)
        XCTAssertNotNil(decodedEventPayloadJSON.creationUTCOffset)

        XCTAssertEqual(decodedExpectedJSON.creationDate, Date(timeIntervalSince1970: 1_600_904_569))
        XCTAssertGreaterThan(decodedEventPayloadJSON.creationDate, Date(timeIntervalSince1970: 1_600_904_569))
    }

    func testInteractionEventEncoding() throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .secondsSince1970

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970

        let interaction = try InteractionTestHelpers.loadInteraction(named: "Survey")

        let event: Event = .launch(from: interaction)

        let eventPayload = Payload(wrapping: event)

        let encodedEventPayload = try jsonEncoder.encode(eventPayload)

        let expectedJSONString = """
            {
                "event": {
                    "nonce": "abc123",
                    "client_created_at": 1600904569,
                    "client_created_at_utc_offset": 0,
                    "label": "com.apptentive#Survey#launch",
                    "interaction_id": "\(event.interaction!.id)"
                }
            }
            """

        let encodedExpectedJSON = expectedJSONString.data(using: .utf8)!

        let decodedExpectedJSON = try jsonDecoder.decode(Payload.self, from: encodedExpectedJSON)
        let decodedEventPayloadJSON = try jsonDecoder.decode(Payload.self, from: encodedEventPayload)

        XCTAssertEqual(decodedEventPayloadJSON.contents, decodedExpectedJSON.contents)

        XCTAssertNotNil(decodedEventPayloadJSON.nonce)
        XCTAssertNotNil(decodedEventPayloadJSON.creationDate)
        XCTAssertNotNil(decodedEventPayloadJSON.creationUTCOffset)

        XCTAssertEqual(decodedExpectedJSON.creationDate, Date(timeIntervalSince1970: 1_600_904_569))
        XCTAssertGreaterThan(decodedEventPayloadJSON.creationDate, Date(timeIntervalSince1970: 1_600_904_569))
    }

    func testEventUserInfoEncoding() throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .secondsSince1970

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970

        let interaction = try InteractionTestHelpers.loadInteraction(named: "NavigateToLink")

        let event: Event = .navigate(to: URL(string: "https://www.apptentive.com")!, success: true, interaction: interaction)

        let eventPayload = Payload(wrapping: event)

        let encodedEventPayload = try jsonEncoder.encode(eventPayload)

        let expectedJSONString = """
            {
                "event": {
                    "nonce": "abc123",
                    "client_created_at": 1600904569,
                    "client_created_at_utc_offset": 0,
                    "label": "com.apptentive#NavigateToLink#navigate",
                    "interaction_id": "\(event.interaction!.id)",
                    "data": {
                        "url": "https://www.apptentive.com",
                        "success": true
                    }
                }
            }
            """

        let encodedExpectedJSON = expectedJSONString.data(using: .utf8)!

        let decodedExpectedJSON = try jsonDecoder.decode(Payload.self, from: encodedExpectedJSON)
        let decodedEventPayloadJSON = try jsonDecoder.decode(Payload.self, from: encodedEventPayload)

        XCTAssertEqual(decodedEventPayloadJSON.contents, decodedExpectedJSON.contents)

        XCTAssertNotNil(decodedEventPayloadJSON.nonce)
        XCTAssertNotNil(decodedEventPayloadJSON.creationDate)
        XCTAssertNotNil(decodedEventPayloadJSON.creationUTCOffset)

        XCTAssertEqual(decodedExpectedJSON.creationDate, Date(timeIntervalSince1970: 1_600_904_569))
        XCTAssertGreaterThan(decodedEventPayloadJSON.creationDate, Date(timeIntervalSince1970: 1_600_904_569))
    }
}
