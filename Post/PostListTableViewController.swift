//
//  PostListTableViewController.swift
//  Post
//
//  Created by Collin Cannavo on 6/13/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    var postController = PostController()
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func refreshControlActivated(_ sender: Any) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        postController.fetchPosts { 
            guard let refreshControl = sender as? UIRefreshControl else { return }
            refreshControl.endRefreshing()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func presentNewPostAlert() {
        
        
        
        let alertController = UIAlertController(title: "Add New Post", message: "Please add a new post", preferredStyle: .alert)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        postController.delegate = self

        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postController.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)

        let posts = postController.posts[indexPath.row]
        
        cell.textLabel?.text = posts.username
        cell.detailTextLabel?.text = "\(indexPath.row) - \(posts.username) - \(Date(timeIntervalSince1970: posts.timestamp))"

        return cell
    }
    
}

extension PostListTableViewController: PostControllerDelegate {

    func postsWereUpdatedTo(posts:[Post], on: PostController) {
        
        tableView.reloadData()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
}












