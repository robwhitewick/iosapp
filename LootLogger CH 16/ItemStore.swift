//
//  ItemStore.swift
//  LootLogger
//
//  Created by Robert Whitewick on 27/04/2023.
//

import UIKit

class ItemStore  {
    var allItems = [Item]()
    
    enum codingError: Error {
        case invalid
        case uncorrect
    }
    
    let itemArchiveUrl: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item:Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //Remove item from array
        allItems.remove(at: fromIndex)
        
        //Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    @objc func saveChanges() throws {
        print("saving items to: \(itemArchiveUrl)")
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allItems)
            
            try data.write(to: itemArchiveUrl, options: [.atomic])
            throw codingError.uncorrect
            
        } catch let encodingError{
            print("error encoding allItemsa: \(encodingError)")
            throw codingError.invalid
        }
    }
    

    
    
    init() {
        do {
            let data = try Data(contentsOf: itemArchiveUrl)
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode([Item].self, from: data)
            allItems = items
        } catch {
            print("Error reading in saved items: \(error)")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)
    

        
                                       
    }
}


