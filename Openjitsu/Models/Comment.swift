//
//  Comment.swift
//  Openjitsu
//
//  Created by Denis Carnier on 15/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment {
    let id: String
    let name: String
    let username: String
    let timestamp: String
    let content: String
}

extension Comment {
    static func fromJSON(json: JSON) -> Comment {
        let id = json["id"].stringValue
        let name = json["name"].stringValue
        let username = json["username"].stringValue
        let timestamp = json["timestamp"].stringValue
        let content = json["content"].stringValue
        
        return Comment(id: id, name: name, username: username, timestamp: timestamp, content: content)
    }
}
