//
//  SignUpViewController.swift
//  Vassar MarketPlace
//
//  Created by Karan Pandya on 4/23/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "CreateProfile", sender: nil)
            } else{
                print("Error: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

}
