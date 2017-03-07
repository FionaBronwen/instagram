//
//  TimelineViewController.swift
//  Instagram
//
//  Created by Fiona Thompson on 3/7/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        
        PFUser.logOutInBackground { (error: Error?) in      //sets PFUser to nil
            print("Current user set to: \(PFUser.current())")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        print("move to login screen")
        self.present(vc, animated: true, completion: nil)

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
