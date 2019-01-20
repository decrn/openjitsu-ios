//
//  DetailViewController.swift
//  Openjitsu
//
//  Created by Denis Carnier on 12/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class DetailViewController: UIViewController {

    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var titleLabel: VerticalAlignLabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var commentsNavButton: UIBarButtonItem!
    
    @IBOutlet var videoPlayer: YTPlayerView!
    
    
    func configureView() {
        
        // Update the user interface for the detail item.
        if let detail = detailItem {
            navigationItem.title = detail.title
            
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
            
            if let player = videoPlayer {
                // SOURCE: https://github.com/youtube/youtube-ios-player-helper
                let playerVars = [  
                    "playsinline" : 1,
                    "showinfo" : 0,
                    "rel" : 0,
                    "modestbranding" : 1,
                    "controls" : 1,
                    "origin" : "https://www.example.com"
                    ] as [String : Any]
                
                // TODO: load the right video url
                player.load(withVideoId: "ZyK1BFZD0Qs", playerVars: playerVars)
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
        case "showComments"?:
             let commentsViewController = segue.destination as! CommentsViewController
             commentsViewController.comments = detailItem!.comments
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func didPressWikipedia(_ sender: Any) {
        // TODO: load the right page
        UIApplication.shared.open(URL(string: detailItem?.wikiUrl ?? "https://en.wikipedia.org/wiki/Guard_(grappling)")!)
    }
}

