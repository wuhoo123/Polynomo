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
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    
    var post: PostModel?
    
    override func viewDidLoad() {
        print(post!.sponsor_id)
        shortTitleText.text = post?.shortTitle
        
        if post?.summary == "" {
//            summaryText.text = "Summary is not yet available :("
            longTitleText.text = post?.title
        }
        else {
            summaryText.text = post?.summary
            longTitleText.text = ""

        }
        sponsorButton.setTitle("\(post!.billSponsor)", for: .normal)
        
        // Adds rounded corners.
        likeButton.layer.cornerRadius = 5
        dislikeButton.layer.cornerRadius = 5

    }

    @IBAction func sponsorButtonPressed(_ sender: Any) {
        print("\(post!.billSponsor) pressed")
        performSegue(withIdentifier: Constant.Segue.detailToPost, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.Segue.detailToPost {
            if let destination = segue.destination as? ProfileVC{
                destination.sponsor_id = post?.sponsor_id
                //destination.id = post[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "DetailToComment", sender: self)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        likeButton.backgroundColor = UIColor.systemGray6
        
    }
    
    
    @IBAction func dislikeButtonPressed(_ sender: Any) {
        dislikeButton.backgroundColor = UIColor.systemGray6
    }
}
