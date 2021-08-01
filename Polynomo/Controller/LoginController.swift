//
//  LoginController.swift
//  Polynomo
//
//  Created by William Wu on 7/26/21.
//

import Foundation
import UIKit
import Firebase

class LoginController: UIViewController {
    
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        emailLogin.layer.cornerRadius = 5
        passwordLogin.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailLogin.text, let password = passwordLogin.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self!.performSegue(withIdentifier: "LoginToEnter", sender: self)
                }
              
            }
            
        }
        
        
    }
    
    
    @IBAction func signupToLoginPressed(_ sender: Any) {
        performSegue(withIdentifier: "LoginToSignup", sender: self)
    }
    
}
