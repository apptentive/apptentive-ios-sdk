//
//  MessageManager.swift
//  ApptentiveKit
//
//  Created by Luqmaan Khan on 9/16/21.
//  Copyright © 2021 Apptentive, Inc. All rights reserved.
//

import Foundation

/// Represents an object that is notified when messages are refreshed from the backend.
protocol MessageManagerDelegate: AnyObject {
    var downloadedMessageList: MessageList? { get set }
}

/// Provides multiple ways to interact with the MessageList.
class MessageManager {

    var delegate: MessageManagerDelegate?

    /// The Message List object.
    ///
    /// The message list is fetched from the server on launch and saved to disk.
    var messageList: MessageList? {
        didSet {
            self.lastFetchDate = Date()
            if let messageList = messageList {
                self.delegate?.downloadedMessageList = messageList
            }
        }
    }

    var lastFetchDate: Date?

    /// The persistence repository used for the message list.
    var messageListRepository: PropertyListRepository<MessageList>?

    static func createRepository(containerURL: URL, filename: String, fileManager: FileManager) -> PropertyListRepository<MessageList> {
        return PropertyListRepository<MessageList>(containerURL: containerURL, filename: filename, fileManager: fileManager)
    }

    func load(from loader: Loader) throws {
        self.messageList = try loader.loadMessages()
    }

    func saveMessagesToDisk() throws {
        if let messageListRepository = self.messageListRepository,
            let messageList = self.messageList
        {
            try messageListRepository.save(messageList)
        }
    }
}
