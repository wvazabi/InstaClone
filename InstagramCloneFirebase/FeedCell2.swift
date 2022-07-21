//
//  FeedCell2.swift
//  InstagramCloneFirebase
//
//  Created by Enes Kaya on 22.07.2022.
//

import UIKit

class FeedCell2: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userComment: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeClickedButton(_ sender: Any) {
    }
    

}
