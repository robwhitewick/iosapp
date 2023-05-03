//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Robert Whitewick on 27/04/2023.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    static var itemStore:ItemStore!
    static var imageStore: ImageStore!
    
    static var itemStore2: ItemStore! {
        didSet {
            itemStore.allItems = itemStore2.allItems
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        //Create a new item and add it to the store
        let newItem = ItemsViewController.itemStore.createItem()
        
        //Figure out where that item is in the array
        if let index = ItemsViewController.itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            //Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }

        print("fired")
        NotificationCenter.default
            .post(name: Notification.Name("test"), object: nil)
    }
    
    @objc func updatePls() {
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
        NotificationCenter.default.addObserver(self,
                                       selector: #selector(updatePls),
                                       name: Notification.Name("test"),
                                       object: nil)
    }
    

    
    
    
    override func tableView(_ tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
        return ItemsViewController.itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recylced cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        //Set the text on the cell with description of the item
        //that is at the nth index of items, where n = row this cell
        // will appear in on the table view
        let item = ItemsViewController.itemStore.allItems[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "£\(item.valueInDollars)"
        if item.valueInDollars >= 50 {
            cell.valueLabel.textColor = .red
        } else {
            cell.valueLabel.textColor = .green
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle:UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        //if the table view is asking to commit a delete command....
        if editingStyle == .delete {
            let item = ItemsViewController.itemStore.allItems[indexPath.row]
            
            //Remove the item from the store
            ItemsViewController.itemStore.removeItem(item)
            
            //remove the item's image from the image store
            ItemsViewController.imageStore.deleteImage(forkey: item.itemKey)
            
            //Also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
            NotificationCenter.default
                .post(name: Notification.Name("test"), object: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath) {
        
        //Update the model
        ItemsViewController.itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        NotificationCenter.default
            .post(name: Notification.Name("test"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If the triggered segue is "showItem" segue
        switch segue.identifier {
        case "showItem":
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                //Get the item associated with this row and pass it along
                let item = ItemsViewController.itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = ItemsViewController.imageStore
            }
        default: preconditionFailure("Unexpected segue identifer")
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
}


