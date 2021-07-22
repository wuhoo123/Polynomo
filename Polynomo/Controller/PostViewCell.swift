//
//  PostViewCell.swift
//  Polynomo
//
//  Created by William Wu on 7/21/21.
//

import UIKit

class PostViewCell: UITableViewCell {

    @IBOutlet weak var postBackground: UIView!
    @IBOutlet weak var shortTitleText: UILabel!
    @IBOutlet weak var shortSummaryText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        postBackground.layer.cornerRadius = 5

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
