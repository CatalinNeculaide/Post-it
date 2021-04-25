//
//  RegisterViewController.swift
//  Post It
//
//  Created by Catalin Neculaide on 25.04.2021.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_nav_up"), style: .done, target: self, action: #selector(goBack))
        
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        if displayNameTextField.text != "" && usernameTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != "" {
            
            if passwordTextField.text == repeatPasswordTextField.text {
                registerUser(username: usernameTextField.text!, password: passwordTextField.text!, displayName: displayNameTextField.text!)
                _ = navigationController?.popToRootViewController(animated: true)
                
            } else {
                UIAlertController.showOKAlert(on: self, title: "Oops, something went wrong", message: "Passwords need to match!")
            }
            
        } else {
            UIAlertController.showOKAlert(on: self, title: "Oops, something went wrong", message: "You need to fill all TextFields")
        }
    }
    
    @objc func goBack(){
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func registerUser(username: String, password: String, displayName: String){
        APIManagers.shared.registerUser(username: username, password: password, displayName: displayName) { (isSuccess, error, json) in
            if isSuccess == true {
                print("User Registered Successfully")
                
            } else {
                print("Register failed!")
            }
        }
    }
}
