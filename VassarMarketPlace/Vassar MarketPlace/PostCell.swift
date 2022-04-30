//
//  PostCell.swift
//  Vassar MarketPlace
//
//  Created by Riik Acharya on 4/29/22.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
