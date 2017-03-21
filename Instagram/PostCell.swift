//
//  PostCell.swift
//  Instagram
//
//  Created by Fiona Thompson on 3/7/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var usernameLabel2: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post: Post!{
        didSet{
            postImageView.file = post.pictureFile
            postImageView.loadInBackground()
            
            let user = post.author
            if let profileImageFile = user?.object(forKey: "profilePhotoFile") {
                profileImageView.file = profileImageFile as? PFFile
                profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
                
                profileImageView.clipsToBounds = true
                profileImageView.loadInBackground()
            }
            
        }
    }
    
    func doubleTapped() {
        self.likeButton.imageView?.image = UIImage(named: "heartRed")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        postImageView.addGestureRecognizer(tap)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
