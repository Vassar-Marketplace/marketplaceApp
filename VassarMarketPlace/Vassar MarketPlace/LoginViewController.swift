//
//  LoginViewController.swift
//  Vassar MarketPlace
//
//  Created by Karan Pandya on 4/18/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user,error) in
            if user != nil{
                self.performSegue(withIdentifier: "FeedView", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
