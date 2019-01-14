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

        // Load some dummy data
        // loadSampleExploreItems()
        
        // Load real data
        refreshTable()
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
    
    // MARK: Private methods
    
    // NOTE: this method is no longer used, since we are now loading data over the network.
    private func loadSampleExploreItems() {
        items.append(ExploreItem(title: "Full Guard", description: "A sample description for the fullest of guards.", image: UIImage(named: "ExploreItem_Thumb")!))
        items.append(ExploreItem(title: "De La Riva Guard", description: "A sample description for De La Riva.", image: UIImage(named: "ExploreItem_Thumb")!))
        items.append(ExploreItem(title: "Half Mount", description: "Half mount is super cool.", image: UIImage(named: "ExploreItem_Thumb")!))
        items.append(ExploreItem(title: "Side Mount", description: "Side mount is even cooler. It's where you have side control.", image: UIImage(named: "ExploreItem_Thumb")!))
        items.append(ExploreItem(title: "Knee on Belly", description: "Neon Bellies, they light up in the dark.", image: UIImage(named: "ExploreItem_Thumb")!))
    }
    
    @IBAction func refreshTable() {
        WebService.getAllItems { completion in
            self.items = completion != nil ? completion! : []
            self.tableView.reloadData()
        }
    }
}

