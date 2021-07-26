//
//  SignupController.swift
//  Polynomo
//
//  Created by William Wu on 7/26/21.
//

import Foundation
import UIKit


class SignupController: UIViewController {
    //
    
    override func viewDidLoad() {

    }
    @IBAction func loginToSignupPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "SignupToLogin", sender: self)
    }
    
    
    
    
}
