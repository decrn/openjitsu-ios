//
//  ExploreItem.swift
//  Openjitsu
//
//  Created by Denis Carnier on 13/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import UIKit

class ExploreItem {
    var title: String
    var description: String
    var photo: UIImage?
    
    init(title: String, description: String, photo: UIImage?) {
        self.title = title
        self.description = description
        self.photo = photo
    }
}
