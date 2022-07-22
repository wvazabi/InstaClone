//
//  FeedCell2.swift
//  InstagramCloneFirebase
//
//  Created by Enes Kaya on 22.07.2022.
//

import UIKit
import Firebase
import FirebaseFirestore


class FeedCell2: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var documentIDLabel: UILabel!
    
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
        
        let firestore = Firestore.firestore()
        
        if let likeCount  = Int(likeCountLabel.text!){
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
        
            firestore.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true)
        
        
        }
        
    }
    

}
