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
    let username: String
    let date: Date
    let content: String
}

extension Comment {
    static func fromJSON(json: JSON) -> Comment {
        let id = json["id"].stringValue
        let username = json["username"].stringValue
        let content = json["content"].stringValue
    
        let timestamp = json["timestamp"].doubleValue
        let date = Date(timeIntervalSince1970: timestamp)
        
        
        return Comment(id: id, username: username, date: date, content: content)
    }
}
