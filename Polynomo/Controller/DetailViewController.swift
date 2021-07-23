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
    
    var post: PostModel?
    
    override func viewDidLoad() {
        shortTitleText.text = post?.shortTitle
        longTitleText.text = post?.title
        
        if post?.summary == "" {
            summaryText.text = "Summary is not yet available :("
        }
        else {
            summaryText.text = post?.summary
        }

    }

}
