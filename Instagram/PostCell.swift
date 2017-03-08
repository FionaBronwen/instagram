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
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var usernameLabel2: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post: Post!{
        didSet{
            postImageView.file = post.pictureFile
            postImageView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
