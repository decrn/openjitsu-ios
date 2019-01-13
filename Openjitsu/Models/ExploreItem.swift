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
// Using SwiftyJSON: https://github.com/SwiftyJSON/SwiftyJSON#usage

struct ExploreItem {
    let title: String
    let description: String
    let image: UIImage
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
        
        return ExploreItem(title: title, description: description, image: image)
    }
}
