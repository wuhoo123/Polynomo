//
//  SignupController.swift
//  Polynomo
//
//  Created by William Wu on 7/26/21.
//

import Foundation
import UIKit


class SignupController: UIViewController {
    
    @IBOutlet weak var emailSignup: UITextField!
    @IBOutlet weak var usernameSignup: UITextField!
    @IBOutlet weak var passwordSignup: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        emailSignup.layer.cornerRadius = 5
        usernameSignup.layer.cornerRadius = 5
        passwordSignup.layer.cornerRadius = 5
        signupButton.layer.cornerRadius = 5
    }
    @IBAction func loginToSignupPressed(_ sender: Any) {
        performSegue(withIdentifier: "SignupToLogin", sender: self)
    }
    
    
    
    
}