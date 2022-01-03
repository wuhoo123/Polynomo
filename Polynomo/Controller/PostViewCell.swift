//
//  PostViewCell.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

import Foundation
import UIKit

protocol PostViewCellDelegate {
    func commentPressed()
}

class PostViewCell: UITableViewCell {

    @IBOutlet weak var postBackground: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shortTitleText: UILabel!
    @IBOutlet weak var shortSummaryText: UILabel!
    @IBOutlet weak var sponsorButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
        
    var delegate: PostViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Adds rounded corners.
        postBackground.layer.cornerRadius = 5
        likeButton.layer.cornerRadius = 5
        dislikeButton.layer.cornerRadius = 5

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        likeButton.backgroundColor = UIColor.systemGray6
        
    }
    
    @IBAction func dislikeButtonPressed(_ sender: Any) {
        dislikeButton.backgroundColor = UIColor.systemGray6
        
    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        print("hi")
        self.delegate?.commentPressed()
    }
    
}
