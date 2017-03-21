//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Fiona Thompson on 3/20/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var bioTextView: UITextView!
    
    var editedProfileImage: UIImage?
    var bio: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()
        
        profileImageView.file = user?.object(forKey: "profilePhotoFile") as? PFFile
        profileImageView.load { (image: UIImage?, error: Error?) in
            self.editedProfileImage = image
        }
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.clipsToBounds = true
        bio = user?.object(forKey: "bio") as? String
        self.bioTextView.text = bio
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onChangeProfilePhotoPressed(_ sender: Any) {
        editImage()
    }
   
    func editImage() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        editedProfileImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        
        
        // Do something with the images (based on your use case)
        profileImageView.image = editedProfileImage
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onSavePressed(_ sender: Any) {
        bio = bioTextView.text
        User.updateUserProfile(image: editedProfileImage, withBio: bio) { (success: Bool, error: Error?) in
        }
        self.dismiss(animated: true, completion: nil)
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
