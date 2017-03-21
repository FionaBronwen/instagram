//
//  NewPhotoViewController.swift
//  Instagram
//
//  Created by Fiona Thompson on 3/7/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import MBProgressHUD

class NewPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {



    @IBOutlet weak var captionField: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var editedImage: UIImage?
    var delegate: PostDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if postImageView.image == nil {
            editImage()
        }
    }
    
    func editImage() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        _ = info[UIImagePickerControllerOriginalImage] as! UIImage
        editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        
        // Do something with the images (based on your use case)
        postImageView.image = editedImage
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onShare(_ sender: Any) {
        Post.postUserImage(image: editedImage, withCaption: captionField.text) { (success: Bool, error: Error?) in
            MBProgressHUD.showAdded(to: self.view, animated: true)
            if success {
                self.captionField.text = ""
                self.postImageView.image = nil
                MBProgressHUD.hide(for: self.view, animated: true)
                self.delegate?.postSubmitted()
            }else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print(error?.localizedDescription ?? 0)
            }
        }
        tabBarController?.selectedIndex = 0

    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.captionField.text = ""
        self.postImageView.image = nil
        tabBarController?.selectedIndex = 0
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
