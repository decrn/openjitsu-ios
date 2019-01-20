//
//  MasterViewController.swift
//  Openjitsu
//
//  Created by Denis Carnier on 12/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    private let reuseIdentifier = "ExploreItemCell"

    var detailViewController: DetailViewController? = nil
    
    var items = [ExploreItem]()

    // Search
    var filteredItems = [ExploreItem]()
    var filtering = false
    let searchController = UISearchController(searchResultsController: nil)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show a spinner while we wait for data to load
        // SOURCE: https://stackoverflow.com/a/50590151
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
        // Make a REST call to fetch all the data
        
        WebService.getAllItems { completion in
            self.items = completion != nil ? completion! : []
            self.tableView.reloadData()
        }
        
        // Add search bar
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Explore positions"
        searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
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
        if isFiltering() {
            return filteredItems.count
        }
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ExploreItemViewCell else {
            fatalError("The dequeued cell is not an instance of ExploreItemViewCell")
        }
        let item: ExploreItem
        
        if isFiltering() {
            item = filteredItems[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        cell.photoImageView.image = item.image
        
        return cell
    }
    
    // MARK: Search
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "showDetail"?:
            let detailViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            
            // have to get this manually because of Peek & Pop:
            // indexPathForSelectedRow is nil because
            // using peek and pop we don't yet select any row.

            let selectedCell = sender as! ExploreItemViewCell
            let selection = tableView.indexPath(for: selectedCell)!
            
            if isFiltering() {
                detailViewController.detailItem = filteredItems[selection.row]
            } else {
                detailViewController.detailItem = items[selection.row]
            }
            
            tableView.deselectRow(at: selection, animated: true)
        case "showLogin"?:
            // handled in the storyboard for now
            break;
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func unwindToExplore(unwindSegue: UIStoryboardSegue) {
        
    }
}

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.filteredItems = self.items.filter({ (item) -> Bool in
                return item.title.lowercased().contains(text.lowercased())
            })
            self.filtering = true
        }
        else {
            self.filtering = false
            self.filteredItems = [ExploreItem]()
        }
        tableView.backgroundView = nil
        self.tableView.reloadData()
    }
}

