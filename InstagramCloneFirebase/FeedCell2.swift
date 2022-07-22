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
    
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var documentIDLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userComment: UILabel!
    
    var userLikedClickedArray = [String]()
    
   
    var currentUser = Auth.auth().currentUser!.email!
    
    
    @IBOutlet weak var likeCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonLike.setImage(UIImage(systemName: "suit.heart"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeClickedButton(_ sender: Any) {
        
        let dummy = "User: \(currentUser)"
        let firestore = Firestore.firestore()
        
        
        if (dummy != userEmailLabel.text){
            
            if  buttonLike.tag == 0{
                buttonLike.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                
                if let likeCount  = Int(likeCountLabel.text!){
                    
                    let likeStore = ["likes" : likeCount + 1] as [String : Any]
                    
                    buttonLike.tag = 1
                
                    firestore.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true)
                
                    }
                
                
           
                
                
            }
        
       
        
        
        }
        
    }
    

}
