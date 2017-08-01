//
//  PostController.swift
//  Post
//
//  Created by Collin Cannavo on 6/13/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation

protocol PostControllerDelegate: class {
    func postsWereUpdatedTo(posts:[Post], on: PostController)
    
}

class PostController {
    
    var posts: [Post] = [] {
        didSet {
            delegate?.postsWereUpdatedTo(posts: posts, on: self)
        }
    }
    
    weak var delegate: PostControllerDelegate?
    
    static let baseURL = URL(string: "https://devmtn-post.firebaseio.com/posts/")
    
    func addPosts(completion: @escaping () -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        
    }
    
    func fetchPosts(reset: Bool = true, completion: @escaping () -> Void) {
        
        // Create URL
        guard let unwrappedURL = PostController.baseURL else { completion(); return }
        
        let url = unwrappedURL.appendingPathExtension("json")
        
        //Create the request
        var request = URLRequest(url: url)
        
        request.httpBody = nil
        request.httpMethod = "GET"
        
        // Create and resume data task
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            
            guard let data = data,
                let serializedDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String: Any]]
                else { completion(); return }
            
            // Create the post
            
             let post = serializedDictionary.flatMap { Post(dictionary: $0.1, identifier: $0.0) }
            let sortedPosts = post.sorted(by: { $0.0.timestamp > $0.1.timestamp })
            
            self.posts = sortedPosts
            completion()
            
        }
        dataTask.resume()
    }
    
}
























