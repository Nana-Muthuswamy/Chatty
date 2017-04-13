//
//  LoginViewController.swift
//  Chatty
//
//  Created by Nana on 4/12/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapSignup(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            let user = PFUser()
            user.username = email
            user.email = email
            user.password = password
            user["phone"] = "3016789876"
            
            user.signUpInBackground(block: { [weak self] (success: Bool, error: Error?) in
                if error != nil {
                    print("error: \(error)")
                }
                if success {
                    print("sign up successful!!")
                    self?.toChatRoom()
                }
            })
        }
    }

    @IBAction func login(_ sender: UIButton) {

        if let username = emailTextField.text?.trimmingCharacters(in: .whitespaces), let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces) {

            PFUser.logInWithUsername(inBackground: username, password: password, block: { [weak self] (user, error) in

                if user != nil {
                    print("Login successfull!")
                    self?.toChatRoom()
                } else {
                    print("Login Failed!")
                }
            })
        }
    }
    
    private func toChatRoom() {
        
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: "showChatView", sender: self)
        }
    }

}

