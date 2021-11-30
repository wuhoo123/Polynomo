//
//  PostViewCell.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

import Foundation
import UIKit

class PostViewCell: UITableViewCell {

    @IBOutlet weak var postBackground: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shortTitleText: UILabel!
    @IBOutlet weak var shortSummaryText: UILabel!
    @IBOutlet weak var sponsorButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Adds rounded corners.
        postBackground.layer.cornerRadius = 5

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        
    }

    
    @IBAction func likeButtonPressed(_ sender: Any) {
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
        dislikeButton.setImage(UIImage(systemName: "heart.slash"), for: .normal)
        
    }
    
    @IBAction func dislikeButtonPressed(_ sender: Any) {
        likeButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        dislikeButton.setImage(UIImage(systemName: "heart.slash.fill"), for: .normal)
        
    }
    
}
