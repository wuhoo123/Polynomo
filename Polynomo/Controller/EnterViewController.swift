//
//  ViewController.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

import UIKit

class EnterViewController: UIViewController {

    @IBOutlet weak var brandName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calls the animatedText function to make "Polynomo" animated upon start up.
        animatedText(label: brandName)
        
        // A Timer that moves onto the next Story Board after 2 seconds.
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextView), userInfo: nil, repeats: false)
        
    }
    
    // A function that types out the string one letter at a time
    func animatedText(label: UILabel) {
        label.text = ""
        var characterIndex = 0.0
        let labelText = "Polynomo"
        for letter in labelText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * characterIndex, repeats: false) { (timer) in
                label.text?.append(letter)
            }
            characterIndex += 1
        }
    }
    
    // Moves to next storyboard through seque.
    @objc func moveToNextView() {
        self.performSegue(withIdentifier: "EnterToFeed", sender: nil)
    }
    
    // Function that hides the navigation bar.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true  // Hides the navigation bar
    }
    
    
}
