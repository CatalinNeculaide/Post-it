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
                    let ac = UIAlertController(title: "Oops, something went wrong", message: "Idk what went wrong!", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(ac,animated: true)
                }
            }
        } else {
            let ac = UIAlertController(title: "Oops, something went wrong", message: "You need to fill username and password to login!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac,animated: true)
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

