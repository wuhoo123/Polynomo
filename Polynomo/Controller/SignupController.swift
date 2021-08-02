//
//  SignupController.swift
//  Polynomo
//
//  Created by William Wu on 7/26/21.
//

import Foundation
import UIKit
import Firebase

class SignupController: UIViewController {
    
    @IBOutlet weak var emailSignup: UITextField!
    @IBOutlet weak var usernameSignup: UITextField!
    @IBOutlet weak var passwordSignup: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        emailSignup.layer.cornerRadius = 5
        usernameSignup.layer.cornerRadius = 5
        passwordSignup.layer.cornerRadius = 5
        signupButton.layer.cornerRadius = 5
    }
    

    
    @IBAction func signupPressed(_ sender: Any) {
        if let email = emailSignup.text, let password = passwordSignup.text, let username = usernameSignup.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    // Navigate to ChatViewController
                    self.db.collection("User").addDocument(data: [
                        "email": email,
                        "password": password,
                        "username": username
                    ]) { (error) in
                        if let e = error {
                            print("There was an issue saving data to firestore, \(e)")
                        } else {
                            print("Successfully saved")
                        }
                    }
                    
                    self.performSegue(withIdentifier: "SignupToEnter", sender: self)
                }
            }
        }
        
    }
    
    @IBAction func loginToSignupPressed(_ sender: Any) {
        performSegue(withIdentifier: "SignupToLogin", sender: self)
    }
    
    
    
    
}
