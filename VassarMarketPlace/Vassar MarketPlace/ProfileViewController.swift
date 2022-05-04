//
//  ProfileViewController.swift
//  Vassar MarketPlace
//
//  Created by Riik Acharya on 5/1/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var paymentMethods: UILabel!
    
    var userID: String = ""
    var username: String = ""
    var payment: String = ""
    
    var listings = [[String:Any]]()
    
    var numFollowers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)

        
        let query = PFQuery(className:"Posts")
        query.whereKey("userId", equalTo: userID)
        
        do {
            let results = try query.findObjects()
            self.listings = results as! [[String:Any]]
            
            profileUsername.text = username as String
            paymentMethods.text = payment as String
            
            self.collectionView.reloadData()
        }
        catch {
            
        }
        
    }
    
    @IBAction func onFollow(_ sender: Any) {
        numFollowers += 1
    }
    
    
    @IBAction func onMessage(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCell", for: indexPath) as! ListingCell
        
        let listing = listings[indexPath.item]
        
        if let imageFile = listing["itemImage"] as? PFFileObject {
            print(imageFile)
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.listingView.af.setImage(withURL: url)
        }
        
        return cell
    }
    
    
}
