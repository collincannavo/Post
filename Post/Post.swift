//
//  Post.swift
//  Post
//
//  Created by Collin Cannavo on 6/13/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation

class Post {
    
    static private let usernameKey = "username"
    static private let textKey = "text"
    static private let timestampKey = "timestamp"

    let username: String
    let text: String
    let timestamp: TimeInterval
    let identifier: UUID
    
    init(username: String, text: String, timestamp: TimeInterval = Date().timeIntervalSince1970, identifier: UUID = UUID()) {
        
        self.username = username
        self.text = text
        self.timestamp = timestamp
        self.identifier = identifier
    }
    
    
    init?(dictionary: [String:Any], identifier: String) {
        
        guard let username = dictionary[Post.usernameKey] as? String,
            let text = dictionary[Post.textKey] as? String,
            let timestamp = dictionary[Post.timestampKey] as? Double,
            let identifier = UUID(uuidString: identifier) else { return nil}
        
        self.username = username
        self.text = text
        self.timestamp = TimeInterval(floatLiteral: timestamp)
        self.identifier = identifier
        
        
    }
    var dictionaryRepresentation: [String: Any] {
        return [Post.usernameKey: username]
    }
    
    var jsonData: Data? {
        let data = (try? JSONSerialization.data(withJSONObject: self.dictionaryRepresentation, options: .prettyPrinted))
        return data
    }
    
}











//    var dictionaryRepresentation: [String:Any] {
//
//        return [Post.usernameKey: username]
//    }
//
//
//    var jsonData: Data? {
//        let data = (try? JSONSerialization.data(withJSONObject: self.dictionaryRepresentation, options: .prettyPrinted))
//        return data
//    }










