//
//  MessageReceivedCell.swift
//  ApptentiveKit
//
//  Created by Luqmaan Khan on 10/14/21.
//  Copyright © 2021 Apptentive, Inc. All rights reserved.
//

import UIKit

class MessageReceivedCell: UITableViewCell {
    let messageLabel: UILabel
    let profileImageView: ApptentiveImageView
    let senderLabel: UILabel
    let dateLabel: UILabel
    let bubbleImageView: UIImageView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.messageLabel = UILabel(frame: .zero)
        self.dateLabel = UILabel(frame: .zero)
        self.senderLabel = UILabel(frame: .zero)
        self.profileImageView = ApptentiveImageView()
        self.bubbleImageView = UIImageView(image: .apptentiveReceivedMessageBubble)

        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.bubbleImageView)
        self.contentView.addSubview(self.senderLabel)
        self.contentView.addSubview(self.messageLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.profileImageView)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.backgroundColor = .clear

        self.messageLabel.textColor = .apptentiveMessageLabelInbound
        self.senderLabel.textColor = .apptentiveMessageLabelInbound
        self.dateLabel.textColor = .apptentiveMessageLabelInbound

        self.bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        self.bubbleImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.bubbleImageView.tintColor = .apptentiveMessageBubbleInbound

        self.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = 8

        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.numberOfLines = 0
        self.dateLabel.font = .apptentiveMessageDateLabel
        self.dateLabel.textAlignment = .left
        self.dateLabel.adjustsFontForContentSizeCategory = true

        self.messageLabel.font = .apptentiveMessageLabel
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.messageLabel.numberOfLines = 0
        self.messageLabel.lineBreakMode = .byWordWrapping
        self.messageLabel.adjustsFontSizeToFitWidth = true
        self.messageLabel.minimumScaleFactor = 0.5
        self.messageLabel.sizeToFit()
        self.messageLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.messageLabel.adjustsFontForContentSizeCategory = true

        self.senderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.senderLabel.numberOfLines = 0
        self.senderLabel.font = .apptentiveSenderLabel
        self.senderLabel.textAlignment = .left
        self.senderLabel.adjustsFontForContentSizeCategory = true

        self.setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                self.bubbleImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
                self.bubbleImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40),
                self.bubbleImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
                self.bubbleImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),

                self.senderLabel.topAnchor.constraint(equalTo: self.bubbleImageView.topAnchor, constant: 10),
                self.senderLabel.leadingAnchor.constraint(equalTo: self.bubbleImageView.leadingAnchor, constant: 20),
                self.senderLabel.trailingAnchor.constraint(equalTo: self.bubbleImageView.trailingAnchor, constant: -10),

                self.messageLabel.topAnchor.constraint(equalTo: self.senderLabel.bottomAnchor, constant: 10),
                self.messageLabel.leadingAnchor.constraint(equalTo: self.senderLabel.leadingAnchor),
                self.messageLabel.trailingAnchor.constraint(equalTo: self.senderLabel.trailingAnchor),
                self.messageLabel.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: -10),

                self.dateLabel.leadingAnchor.constraint(equalTo: self.senderLabel.leadingAnchor),
                self.dateLabel.trailingAnchor.constraint(equalTo: self.senderLabel.trailingAnchor),
                self.bubbleImageView.bottomAnchor.constraint(equalToSystemSpacingBelow: self.dateLabel.bottomAnchor, multiplier: 2.0),

                self.profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
                self.profileImageView.bottomAnchor.constraint(equalTo: self.bubbleImageView.bottomAnchor),
                self.profileImageView.heightAnchor.constraint(equalToConstant: 22),
                self.profileImageView.widthAnchor.constraint(equalToConstant: 22),
            ]
        )
    }
}
