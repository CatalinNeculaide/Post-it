//
//  Message.swift
//  Post It
//
//  Created by Catalin Neculaide on 24.04.2021.
//

import Foundation
import SwiftyJSON


class Message {
    
    var textMessage: String = String()
    var userid : Int?
    var displayName : String?
    var date = String()
    
    func configure(json: JSON){
        
        textMessage = json["message"].string!
        userid = json["user_id"].int ?? nil
        displayName = json["display_name"].string ?? nil
        
        let rawDate = json["created_at"].string!
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+2") as TimeZone?
        let dateParsed = dateFormatter.date(from: rawDate)
        
        date = "\(dateParsed!)"
        
    }
    
}
