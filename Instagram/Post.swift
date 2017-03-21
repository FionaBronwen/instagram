//
//  Post.swift
//  Instagram
//
//  Created by Fiona Thompson on 3/7/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    var author: PFUser?
    var caption: String?
    var commentCount: Int?
    var likesCount: Int?
    
    var pictureFile: PFFile?
    
    init(pfObject: PFObject) {
        self.author = pfObject["author"] as? PFUser
        self.caption = pfObject["caption"] as? String
        self.commentCount = pfObject["commentCount"] as? Int
        self.likesCount = pfObject["likesCount"] as? Int
        self.pictureFile = pfObject["media"] as? PFFile
    }
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        let image = UIImage.resize(image: image!, newSize: CGSize(width: 612, height: 612))
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
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
    class func getPosts(success: @escaping ([Post]) -> (), failure: @escaping (Error) -> ()) {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (pfObjects: [PFObject]?, error: Error?) in
            if let pfObjects = pfObjects {
                let posts = formPostsArray(from: pfObjects)
                success(posts)
            } else {
                print("\(error?.localizedDescription)!")
                failure(error!)
            }
        }
    }
    
    class func getUserPosts(user: PFUser, success: @escaping ([Post]) -> (), failure: @escaping (Error) -> ()) {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: user)
        
        // fetch data asynchronously
        query.findObjectsInBackground { (pfObjects: [PFObject]?, error: Error?) in
            if let pfObjects = pfObjects {
                let posts = formPostsArray(from: pfObjects)
                success(posts)
            } else {
                print("\(error?.localizedDescription)!")
                failure(error!)
            }
        }
    }
    
    class func formPostsArray(from pfObjectArray: [PFObject]) -> [Post]{
        var posts: [Post] = []
        for pfObject in pfObjectArray {
            let post = Post(pfObject: pfObject)
            posts.append(post)
        }
        return posts
    }
    
    

}
