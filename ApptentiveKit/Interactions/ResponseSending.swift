//
//  ResponseSending.swift
//  ApptentiveKit
//
//  Created by Frank Schmitt on 10/6/20.
//  Copyright © 2020 Apptentive, Inc. All rights reserved.
//

import Foundation

/// Describes an object that can send responses from interactions.
protocol ResponseSending {

    /// Sends the specified survey response to the Apptentive API.
    /// - Parameter surveyResponse: The survey response to send.
    func send(surveyResponse: SurveyResponse)

    /// Engages the specified event by including the interaction.
    /// - Parameters:
    ///   - event: The event to engage.
    ///   - interaction: The interaction that sent the event.
    func engage(event: Event, from interaction: Interaction)
}