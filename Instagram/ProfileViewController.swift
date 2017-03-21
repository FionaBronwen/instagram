//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Fiona Thompson on 3/20/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        let user = PFUser.current()
        
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        editProfileButton.layer.cornerRadius = 4
        
        profileImageView.layer.cornerRadius = 48
        profileImageView.clipsToBounds = true
        
        let file = user?.object(forKey: "profilePhotoFile") as! PFFile
        profileImageView.file = file
        profileImageView.loadInBackground()
        
        usernameLabel.text = user?.username
        bioLabel.text = user?.object(forKey: "bio") as! String?

        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell
        return cell!
    }
    
    
    
    
    @IBAction func onEditProfilePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "EditProfileSegue", sender: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
