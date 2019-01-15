//
//  DetailViewController.swift
//  Openjitsu
//
//  Created by Denis Carnier on 12/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var titleLabel: VerticalAlignLabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var commentsNavButton: UIBarButtonItem!
    
    func configureView() {
        
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = descriptionLabel {
                label.text = detail.description
            }
            if let label = titleLabel {
                label.text = detail.title
            }
            if let label = contentLabel {
                label.text = detail.content
            }
            if let thumb = thumbnailImage {
                thumb.image = detail.image
            }
            if let commentNav = commentsNavButton {
                // Do some trimming of the nav item title
                let commentCount = detail.comments.count
                if (commentCount == 1) {
                    commentNav.title = "1 Comment"
                } else if (commentCount > 99) {
                    commentNav.title = "99+ Comments"
                } else {
                    commentNav.title = "\(commentCount) Comments"
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: ExploreItem? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    @IBAction func didPressFavoriteButton(_ sender: Any) {
        if (!favoriteButton.isSelected) {
            // TODO: Make a seperate section in master table view with favorites
            
            let alertTitle = "Favorites"
            let alertMessage = "\(detailItem?.title ?? "This item") has been added to your favorites!"
            
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        favoriteButton.isSelected = !favoriteButton.isSelected
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        //case "showComments"?:
            // let commentsViewController = (segue.destination as! UINavigationController).topViewController as! CommentsViewController
            // commentsViewController.comments = detailItem.comments
        default:
            fatalError("Unknown segue")
        }
    }
    
}

