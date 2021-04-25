//
//  APIManager.swift
//  Post It
//
//  Created by Catalin Neculaide on 24.04.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIManagers {
    
    static let shared = APIManagers()
    
    func getAllMessages(completionHandler: @escaping (Bool, Error?, [JSON]?) -> Void){
        let url = "https://intern-hackathon.mready.net/api/posts"
        AF.request(url, method: .get, parameters: nil).responseJSON { (dataResponse) in
            
            if let data = dataResponse.value {
                let json = JSON(data)
                completionHandler(true, dataResponse.error, json["data"].array)
                return
            }
            
            completionHandler(false, dataResponse.error, nil)
            
        }
        
    }
    
    func sendMessage(message: String, user_id: String?, completionHandler: @escaping (Bool) -> Void){
        var param = [String:Any]()
        let url = "https://intern-hackathon.mready.net/api/posts"
        
        if user_id != nil {
            param = ["message": message, "user_id": user_id!] as [String:Any]
        } else {
            param = ["message": message] as [String:Any]
        }
        
        AF.request(url, method: .post, parameters: param).responseJSON { (dataResponse) in
            
            if let _ = dataResponse.value{
                completionHandler(true)
                return
            }
            print("Error: \(dataResponse.error!)")
            completionHandler(false)
        }
    }
    
    func registerUser (username: String, password: String, displayName: String, completionHandler: @escaping (Bool,Error?,JSON?) -> Void){
        var param = [String:Any]()
        let url = "https://intern-hackathon.mready.net/api/auth/register"
        
        param = ["Username": username, "Password": password, "Diplay_name": displayName] as [String:Any]
        
        AF.request(url, method: .post, parameters: param).responseJSON { (dataResponse) in
            if let _ = dataResponse.value{
                debugPrint(dataResponse.result)
                let json = JSON(dataResponse.result)
                completionHandler(true, dataResponse.error, json["data"])
                return
            }
            
            completionHandler(false, dataResponse.error, nil)
        }
        
    }
    
    func loginUser (username: String, password: String, completionHandler: @escaping (Bool, Error?, JSON?) -> Void){
        var param = [String:Any]()
        let url = "https://intern-hackathon.mready.net/api/auth/login"
        
        param = ["username": username, "password": password]
        
        AF.request(url, method: .post, parameters: param).responseJSON { (dataResponse) in
            if let data = dataResponse.value {
                let json = JSON(data)
                completionHandler(true, dataResponse.error, json["data"])
                return
            }
            completionHandler(false, dataResponse.error, nil)
        }
    }
}
