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
        query.includeKeys(["userName"])
        query.limit = 40
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let user = post["usernameLabel"] as! PFUser
        cell.usernameLabel.text = user.username

        cell.itemDescription.text = post["itemDescription"] as? String

        let imageFile = post["itemImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        let profilePic = post["UserProfilePic"] as! PFFileObject
        let picString = profilePic.url!
        let picUrl = URL(string: picString)!

        cell.itemImage.af.setImage(withURL: url)
        cell.itemImage.af.setImage(withURL: picUrl)

        return cell
       
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
