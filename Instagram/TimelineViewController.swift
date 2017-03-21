//
//  TimelineViewController.swift
//  Instagram
//
//  Created by Fiona Thompson on 3/7/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts: [Post] = []
    var refreshControl: UIRefreshControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(getPosts), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        getPosts()

    }
    
    func getPosts() {
        Post.getPosts(success: { (posts: [Post]) in
            self.posts = posts
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        cell.usernameLabel.text = post.author?.username
        cell.captionLabel.text = post.caption
        cell.likeCountLabel.text = "\((post.likesCount)!)"
        cell.usernameLabel2.text = post.author?.username
        cell.post = post
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
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

extension TimelineViewController: PostDelegate {
    func postSubmitted() {
        self.tableView.reloadData()
    }
}
