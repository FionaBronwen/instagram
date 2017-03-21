//
//  User.swift
//  Instagram
//
//  Created by Fiona Thompson on 3/20/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {

    var user: PFUser?
    var posts: [Post]?
    var postCount: Int?
    var followerCount: Int?
    var followingCount: Int?
    var bio: String?
    var profilePhotoFile: PFFile?
    
    init(pfObject: PFObject) {
        
        self.postCount = pfObject["postCount"] as? Int
        self.followerCount = pfObject["followersCount"] as? Int
        self.followingCount = pfObject["followingCount"] as? Int
        self.bio = pfObject["bio"] as? String
        self.profilePhotoFile = pfObject["profilePhotoFile"] as? PFFile
    }
    
    class func updateUserProfile(image: UIImage?, withBio bio: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        let user = PFUser.current()
        
        user?["profilePhotoFile"] = getPFFileFromImage(image: image) // PFFile column type
        user?["bio"] = bio
        
        user?.saveInBackground()
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
