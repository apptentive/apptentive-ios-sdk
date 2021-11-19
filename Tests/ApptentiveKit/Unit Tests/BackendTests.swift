//
//  BackendTests.swift
//  ApptentiveUnitTests
//
//  Created by Frank Schmitt on 2/4/21.
//  Copyright © 2021 Apptentive, Inc. All rights reserved.
//

import XCTest

@testable import ApptentiveKit

class BackendTests: XCTestCase {
    var backend: Backend!
    var requestor: SpyRequestor!

    override func setUpWithError() throws {
        try MockEnvironment.cleanContainerURL()

        let environment = MockEnvironment()
        let queue = DispatchQueue(label: "Test Queue")

        var conversation = Conversation(environment: environment)
        conversation.appCredentials = Apptentive.AppCredentials(key: "123abc", signature: "456def")
        conversation.conversationCredentials = Conversation.ConversationCredentials(token: "abc123", id: "def456")

        self.requestor = SpyRequestor(responseData: Data())
        let client = HTTPClient(requestor: self.requestor, baseURL: URL(string: "https://api.apptentive.com/")!, userAgent: "foo")
        let requestRetrier = HTTPRequestRetrier(retryPolicy: HTTPRetryPolicy(), client: client, queue: queue)

        let payloadSender = PayloadSender(requestRetrier: requestRetrier)
        payloadSender.credentialsProvider = conversation

        self.backend = Backend(queue: queue, conversation: conversation, targeter: Targeter(), messageManager: MessageManager(), requestRetrier: requestRetrier, payloadSender: payloadSender)
    }

    func testPersonChange() {
        let expectation = XCTestExpectation(description: "Person data sent")

        self.requestor.extraCompletion = {
            if self.requestor.request?.url == URL(string: "https://api.apptentive.com/conversations/def456/person") {
                expectation.fulfill()
            }
        }

        self.backend.conversation.person.name = "Testy McTestface"

        self.wait(for: [expectation], timeout: 5)
    }

    func testDeviceChange() {
        let expectation = XCTestExpectation(description: "Device data sent")

        self.requestor.extraCompletion = {
            if self.requestor.request?.url == URL(string: "https://api.apptentive.com/conversations/def456/device") {
                expectation.fulfill()
            }
        }

        self.backend.conversation.device.customData["string"] = "foo"

        self.wait(for: [expectation], timeout: 5)
    }

    func testAppReleaseChange() {
        let expectation = XCTestExpectation(description: "App release data sent")

        self.requestor.extraCompletion = {
            if self.requestor.request?.url == URL(string: "https://api.apptentive.com/conversations/def456/app_release") {
                expectation.fulfill()
            }
        }

        self.backend.conversation.appRelease.version = "1.2.3"

        self.wait(for: [expectation], timeout: 5)
    }
}
