//
//  ViewController.swift
//  Post It
//
//  Created by Catalin Neculaide on 24.04.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    var user = Users()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loginUserName(username: String, password:String, completionHandler: @escaping (Bool) -> Void){
        APIManagers.shared.loginUser(username: username, password: password) { (isSuccess, error, json) in
            if isSuccess == true {
                self.user.configure(json: json!)
                debugPrint(self.user.token)
                if self.user.username == username{
                    print("Login Successfully")
                    completionHandler(true)
                }
                
            } else {
                print("Login failed!")
                completionHandler(false)
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if usernameTextField.text != "" && passwordTextField.text != "" {
            loginUserName(username: usernameTextField.text!, password: passwordTextField.text!) { (isSuccess) in
                if (isSuccess && self.usernameTextField.text == self.user.username){
                    self.performSegue(withIdentifier: "segueToFeed", sender: self)
                } else {
                    UIAlertController.showOKAlert(on: self, title: "Oops, something went wrong", message: "Check internet connection")
                }
            }
        } else {
            UIAlertController.showOKAlert(on: self, title: "Oops, something went wrong", message: "You need to fill username and password to login!")
        }
        
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "segueToRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is FeedViewController{
            let vc = segue.destination as? FeedViewController
            vc?.user = user
        }
    }

}

