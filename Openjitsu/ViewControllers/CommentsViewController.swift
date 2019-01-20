//
//  CommentsViewController.swift
//  Openjitsu
//
//  Created by Denis Carnier on 20/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import UIKit

class CommentsViewController: UITableViewController {

    private let reuseIdentifier = "CommentCell"
    
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CommentViewCell else {
            fatalError("The dequeued cell is not an instance of CommentViewCell")
        }

        // Configure the cell...
        let comment: Comment
        
        comment = comments[indexPath.row]
        
        cell.authorLabel.text = comment.username
        cell.commentLabel.text = comment.content
        
        // Comment date
        // SOURCE: https://stackoverflow.com/a/35700409
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        cell.dateLabel.text = dateFormatter.string(from: comment.date)

        return cell
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: Private methods
    
    // SOURCE: https://stackoverflow.com/a/36753347
    

}
