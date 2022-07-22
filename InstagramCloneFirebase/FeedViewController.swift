//
//  FeedViewController.swift
//  InstagramCloneFirebase
//
//  Created by Enes Kaya on 20.07.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
  

    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        getDataFromfirestore()
        // Do any additional setup after loading the view.
    }
    
    
    func alertPopUp(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell2
        cell.userComment.text = "Comment: \(userCommentArray[indexPath.row])"
        cell.userEmailLabel.text = "User: \(userEmailArray[indexPath.row])"
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.likeCountLabel.text = String(likeArray[indexPath.row])
            
        
        return cell
    }
    
    
    func getDataFromfirestore(){
        
        let firestoreDataBase = Firestore.firestore()
        
       // let settings = firestoreDataBase.settings
        
        firestoreDataBase.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil {
                self.alertPopUp(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                
                if snapshot != nil && snapshot?.isEmpty != true {
                    
                   
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.userImageArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents {
                         
                        if let postedBy = document.get("postComment") as? String {
                            
                            self.userEmailArray.append(postedBy)
                            
                            if let comment = document.get("comment") as? String{
                                self.userCommentArray.append(comment)
                                
                                if let likes = document.get("likes") as? Int{
                                    self.likeArray.append(likes)
                                    
                                    if let imageUrl = document.get("imageUrl") as? String{
                                        self.userImageArray.append(imageUrl)
                                    }
                                    
                                }
                            }
                            
                        }
                        
                        self.tableView.reloadData()
                    }
                }
                
                
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
