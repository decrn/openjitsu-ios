//
//  MasterViewController.swift
//  Openjitsu
//
//  Created by Denis Carnier on 12/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var items = [ExploreItem]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show a spinner while we wait for data to load
        // SOURCE: https://stackoverflow.com/a/50590151
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
        // Make a REST call to fetch all the data
        
        WebService.getAllItems { completion in
            self.items = completion != nil ? completion! : []
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreItemCell", for: indexPath) as? ExploreItemViewCell else {
            fatalError("The dequeued cell is not an instance of ExploreItemViewCell")
        }

        let item = items[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        cell.photoImageView.image = item.image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "showDetail"?:
            let detailViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            
            // have to get this manually because of Peek & Pop:
            // indexPathForSelectedRow is nil because
            // using peek and pop we don't yet select any row.
            //
            let selectedCell = sender as! ExploreItemViewCell
            let selection = tableView.indexPath(for: selectedCell)!
            detailViewController.detailItem = items[selection.row]
            tableView.deselectRow(at: selection, animated: true)
        case "showLogin"?:
            // handled in the storyboard for now
            break;
        default:
            fatalError("Unknown segue")
        }
    }
}

