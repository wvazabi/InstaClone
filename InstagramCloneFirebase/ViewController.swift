//
//  ViewController.swift
//  InstagramCloneFirebase
//
//  Created by Enes Kaya on 20.07.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signInClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata,errorx) in
                
                if errorx != nil
                {
                    self.alertPopUp(titleInput: "Error!", messageInput: errorx?.localizedDescription ??  "Error")
                        
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else{
            alertPopUp(titleInput: "Error!", messageInput: "Username/Password error")
            
        }
        
    
        
        
    }
    
    func alertPopUp(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    

}

