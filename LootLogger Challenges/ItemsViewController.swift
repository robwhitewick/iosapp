//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Robert Whitewick on 27/04/2023.
//

import UIKit

var headerTitles = [""]

class ItemsViewController: UITableViewController {
    var itemStore:ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton?) {
        tableView.reloadData()
        //Create a new item and add it to the store
        let newItem = itemStore.createItem()
        //Figure out where that item is in the array
        if let index = itemStore.allItems[newItem.section].items.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index,section: newItem.section)
            //Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingmode(_ sender: UIButton) {
        //If you are currently in editing mode...
        if isEditing {
            //Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            //Turn off editing mode
            setEditing(false, animated: true)
        } else {
            //Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            //Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let items = itemStore.allItems[indexPath.section].items
        if items.isEmpty {
            return false
        } else {
            return true
        }

    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        if itemStore.allItems[section].items.count == 0 {
//            //Create a new item and add it to the store
//            let newItem = itemStore.createItem()
//            //Figure out where that item is in the array
//            if let index = itemStore.allItems[newItem.section].items.firstIndex(of: newItem) {
//                let indexPath = IndexPath(row: index,section: newItem.section)
//                //Insert this new row into the table
//                tableView.insertRows(at: [indexPath], with: .automatic)
//            }
        }
        return itemStore.allItems[section].items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("called")
        // Get a new or recylced cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        //Set the text on the cell with description of the item
        //that is at the nth index of items, where n = row this cell
        // will appear in on the table view
        let items = itemStore.allItems[indexPath.section].items
        if items.count != 0 {
            let item = items[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        } else {
            
            cell.textLabel?.text = "Test"
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle:UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        //if the table view is asking to commit a delete command....
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.section].items[indexPath.row]
            print(item)
            //Remove the item from the store
            itemStore.removeItem(item,section: indexPath.section)
            //Also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        
        //Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row,section: destinationIndexPath.section)
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "expensive"
        default:
             return "cheap"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}

