//
//  Event.swift
//  ApptentiveKit
//
//  Created by Frank Schmitt on 10/24/19.
//  Copyright © 2019 Apptentive, Inc. All rights reserved.
//

import Foundation

/// Describes an event that represents a view or action in your app that you would like to track to help trigger interactions.
///
/// Use the `Apptentive` object's `engage(event:from:)` method to record events in your app.
public struct Event: ExpressibleByStringLiteral, Decodable, CustomDebugStringConvertible {
    /// The name of the event as provided by the customer.
    let name: String

    /// The source of the event, basically whether it comes from the host app or is internal.
    let vendor: String

    /// The interaction, if any, that the event was engaged by (the string `app` will be used in the code point if there is no interaction).
    var interaction: Interaction?

    /// Creates an event with the provided name.
    /// - Parameter name: The name of the event.
    public init(name: String) {
        self.name = name
        self.vendor = "local"
        self.interaction = nil
    }

    /// Creates an event with the provided string literal as the name.
    /// - Parameter value: The name of the event.
    public init(stringLiteral value: String) {
        self.init(name: value)
    }

    /// Creates an internal SDK event with the given name and interaction.
    /// - Parameters:
    ///   - internalName: The name of the event.
    ///   - interaction: The interaction engaging the event (defaults to `nil`, representing the `app` interaction).
    init(internalName: String, interaction: Interaction? = nil) {
        self.name = internalName
        self.vendor = "com.apptentive"
        self.interaction = interaction
    }

    /// Convenience property for a launch event.
    static let launch = Self(internalName: "launch")

    /// Convenience property for an exit event.
    static let exit = Self(internalName: "exit")

    /// Convenience property for a submit event (e.g. a survey).
    static let submit = Self(internalName: "submit")

    /// Convenience property for a cancel event (e.g. a survey).
    static let cancel = Self(internalName: "cancel")

    /// Returns a `#`-separated string incorporating the vendor, interaction and name, all appropriately percent-escaped.
    ///
    /// Code points are used when looking up potential invocations in the engagement manifest's `targets` section.
    var codePointName: String {
        let interactionName = self.interaction?.typeName ?? "app"

        return [vendor, interactionName, name].map(escape).joined(separator: "#")
    }

    private static let allowedCharacters = CharacterSet(charactersIn: "#%/").inverted

    /// Escapes an event name to comply with the requirements for code points.
    ///
    /// Characters in the set `#`, `%`, and `/` need to be percent-escaped.
    /// - Parameter string: the string to escape.
    /// - Returns: The escaped string.
    private func escape(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: Self.allowedCharacters) ?? ""
    }

    /// Prints a description for debugging purposes.
    public var debugDescription: String {
        return "Event(codePoint: \(self.codePointName))"
    }
}