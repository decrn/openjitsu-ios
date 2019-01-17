//
//  ExploreItem.swift
//  Openjitsu
//
//  Created by Denis Carnier on 13/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import Foundation
import SwiftyJSON

// Using structs as per the Apple Developer guidelines
// https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes
// I was originally going to use the Codable protocol, as suggested in the "App Development with Swift" book
// But decided on using a library to handle this to see how that works
// Using SwiftyJSON: https://github.com/SwiftyJSON/SwiftyJSON#usage

struct ExploreItem {
    let title: String
    let description: String
    let image: UIImage
    let content: String
    var comments: [Comment]
    let wikiUrl: String
    let youtubeUrl: String
}

extension ExploreItem {
    static func fromJSON(json: JSON) -> ExploreItem {
        let title = json["name"].stringValue
        let description = json["description"].stringValue
        var image: UIImage
        
        // Some safety checks to make sure we're actually getting an image
        do {
            let imageUrl = json["image"].stringValue
            let imageData = try Data(contentsOf: URL(string: imageUrl)!)
            image = UIImage(data: imageData, scale: 1.0)!
        } catch {
            // Load a local Asset if this failed
            image = UIImage(named: "ExploreItem_Thumb")!
        }
        
        let content = json["content"].stringValue
        
        let comments = json["comments"].arrayValue.map { Comment.fromJSON(json: $0)}
        
        let wikiUrl = json["wikipedia"].stringValue
        let youtubeUrl = json["youtube"].stringValue
        
        return ExploreItem(title: title, description: description, image: image, content: content, comments: comments, wikiUrl: wikiUrl, youtubeUrl: youtubeUrl)
    }
}
