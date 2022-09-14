//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            if !email.isEmpty && !password.isEmpty{
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                  guard let self = self else { return }
                    if let error = error{
                        print(error.localizedDescription)
                    }else{
                        self.performSegue(withIdentifier: "LoginToChat", sender: self)
                    }
                }
            }
   
        }
    }
    
}
