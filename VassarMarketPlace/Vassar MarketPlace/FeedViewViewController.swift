//
//  FeedViewViewController.swift
//  Vassar MarketPlace
//
//  Created by Karan Pandya on 4/23/22.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // user can dismiss keyboard by pulling down
        tableView.keyboardDismissMode = .interactive
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["user", "itemDescription", "itemPrice", "itemImage", "userProfilePic"])
        query.limit = 100
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let user = post["user"] as! PFUser
        
        cell.usernameLabel.text = user["name"] as? String

        cell.itemDescription.text = post["itemDescription"] as? String
        
        cell.itemPrice.text = post["itemPrice"] as? String
        
        if let imageFile = post["itemImage"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.itemImage.af.setImage(withURL: url)
        }
        
        if let profilePic = user["profilePic"] as? PFFileObject {
            let picString = profilePic.url!
            let picUrl = URL(string: picString)!
            cell.userProfilePic.af.setImage(withURL: picUrl)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "profileViewSegue"
        {
            let postCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: postCell)
            let post = posts[indexPath!.section]
            
            let user = post["user"] as! PFUser
            
            let userId = user.objectId!
            let name = user["name"] as? String
            let payment = user["payment"] as? String
            
            
            
            let DestinationVC = segue.destination as!
                ProfileViewController
            DestinationVC.userID = userId
            DestinationVC.name = name ?? ""
            DestinationVC.payment = payment ?? ""
            DestinationVC.profilePic = user["profilePic"] as? PFFileObject
        
            tableView.deselectRow(at: indexPath!, animated: true)
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }
    
}
