//
//  LoginController.swift
//  Polynomo
//
//  Created by William Wu on 7/26/21.
//

import Foundation
import UIKit


class LoginController: UIViewController {
    
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        emailLogin.layer.cornerRadius = 5
        passwordLogin.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        performSegue(withIdentifier: "LoginToSignup", sender: self)
    }
    
}
