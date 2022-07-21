//
//  UploadViewController.swift
//  InstagramCloneFirebase
//
//  Created by Enes Kaya on 20.07.2022.
//

import UIKit
import Firebase
import FirebaseStorage


class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
               
               let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(addPic))
               imageView.addGestureRecognizer(gestureRecognizer2)
               

        // Do any additional setup after loading the view.
    }
    
    @objc func addPic(){
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
            
            
        }
    
    func alertPopUp(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           imageView.image = info[.originalImage] as? UIImage
           self.dismiss(animated: true, completion: nil)
           
       }
    
    
    @IBAction func Button(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFile = storageReference.child("media")
        
        let uuid = UUID().uuidString
        
        if let data = imageView.image?.jpegData( compressionQuality: 0.5){
            
            let imageReferance = mediaFile.child("\(uuid).jpeg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.alertPopUp(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                }
                else{
                    
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            
                            //Database
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postComment" : Auth.auth().currentUser!.email!, "comment" : self.editText.text!, "likes" : 0, "date" : FieldValue.serverTimestamp()  ] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.alertPopUp(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                                }else{
                                    self.imageView.image = UIImage(named: "select")
                                    self.editText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                                
                                
                                
                            })
                            
                            
                            
                        }
                        
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
