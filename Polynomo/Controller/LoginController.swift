//
//  LoginController.swift
//  Polynomo
//
//  Created by William Wu on 7/26/21.
//

import Foundation
import UIKit


class LoginController: UIViewController {
    //
    
    override func viewDidLoad() {

    }
    
    @IBAction func signupPressed(_ sender: Any) {
        performSegue(withIdentifier: "LoginToSignup", sender: self)
    }
    
}
