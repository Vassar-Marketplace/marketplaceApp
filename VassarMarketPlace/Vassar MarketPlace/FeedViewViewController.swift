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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
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
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 40
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }

}
