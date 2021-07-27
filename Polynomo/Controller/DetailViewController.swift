//
//  DetailViewController.swift
//  Polynomo
//
//  Created by William Wu on 7/22/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var shortTitleText: UILabel!
    @IBOutlet weak var longTitleText: UILabel!
    @IBOutlet weak var summaryText: UILabel!
    @IBOutlet weak var sponsorButton: UIButton!
    
    var post: PostModel?
    
    override func viewDidLoad() {
        shortTitleText.text = post?.shortTitle
        
        if post?.summary == "" {
            summaryText.text = "Summary is not yet available :("
            longTitleText.text = post?.title
        }
        else {
            summaryText.text = post?.summary
            longTitleText.text = ""

        }
        
        sponsorButton.setTitle(post?.billSponsor, for: .normal)

    }

    @IBAction func sponsorButtonPressed(_ sender: Any) {
        print("button pressed")
    }
}
