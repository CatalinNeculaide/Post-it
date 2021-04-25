//
//  Users.swift
//  Post It
//
//  Created by Catalin Neculaide on 24.04.2021.
//

import Foundation
import SwiftyJSON


class Users{
    
    var username: String = String()
    var displayName: String?
    var token: String = String()
    
    func configure(json: JSON){
        displayName = json["user"]["display_name"].string ?? nil
        username = json["user"]["username"].string!
        token = json["token"].string!
        
    }
}
