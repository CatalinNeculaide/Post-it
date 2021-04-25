//
//  MessageCell.swift
//  Post It
//
//  Created by Catalin Neculaide on 24.04.2021.
//

import Foundation
import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    func configure(_ message: Message){
        if let name = message.displayName {
            usernameLabel.text = name
            usernameLabel.textColor = UIColor.orange
        } else {
            usernameLabel.text = "Anonymous"
            usernameLabel.textColor = UIColor.yellow
        }
        dateLabel.text = message.date
        messageLabel.text = message.textMessage
    }
    
}
