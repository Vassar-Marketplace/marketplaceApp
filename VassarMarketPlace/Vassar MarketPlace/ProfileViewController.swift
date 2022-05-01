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

        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!

        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                self.listings = dataDictionary["results"] as! [[String:Any]]
                
                self.collectionView.reloadData()
            }
        }

        task.resume()
        
    }
    
    @IBAction func onFollow(_ sender: Any) {
        numFollowers += 1
    }
    
    
    @IBAction func onMessage(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCell", for: indexPath) as! ListingCell
        
        let listing = listings[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = listing["poster_path"] as! String
        let listingUrl = URL(string: baseUrl + posterPath)
        
        cell.listingView.af.setImage(withURL: listingUrl!)
        
        return cell
    }
    
    
}
