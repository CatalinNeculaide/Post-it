//
//  PostMsgViewController.swift
//  Post It
//
//  Created by Catalin Neculaide on 24.04.2021.
//

import UIKit

class PostMsgViewController: UIViewController {
    
    var user = Users()

    @IBOutlet weak var textFieldInput: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_nav_up"), style: .done, target: self, action: #selector(goBack))
    }

    @IBAction func submitTapped(_ sender: Any) {
        if textFieldInput.text != ""{
            sendMessage()
        }
    }
    
    func sendMessage(){
        let message = textFieldInput.text!
        APIManagers.shared.sendMessage(message: message, user_id: user.token) { (isSuccess) in
            if isSuccess == true{
                print("Send message successful")
            } else {
                print("Send message Failed")
            }
        }
    }
    
    @objc func goBack(){
        _ = navigationController?.popViewController(animated: true)
    }
}
