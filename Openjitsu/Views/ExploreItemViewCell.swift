//
//  ExploreItemViewCell.swift
//  Openjitsu
//
//  Created by Denis Carnier on 13/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import UIKit

class ExploreItemViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
