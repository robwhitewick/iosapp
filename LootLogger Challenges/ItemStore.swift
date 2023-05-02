//
//  ItemStore.swift
//  LootLogger
//
//  Created by Robert Whitewick on 27/04/2023.
//

import UIKit

struct Category {
    let name : String
    var items: [Item]
}

class ItemStore  {
    var allItems = [
        Category(name: "Expensive", items: [Item]()),
        Category(name: "Cheap", items: [Item]())
    ]
    init(allItems: [Category] = [
        Category(name: "Expensive", items: [Item]()),
        Category(name: "Cheap", items: [Item]())
    ]) {
        
        self.allItems = allItems
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems[newItem.section].items.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item, section: Int) {
        if let index = allItems[section].items.firstIndex(of: item) {
            allItems[section].items.remove(at: index)
            
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int, section: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[section].items[fromIndex]
        
        //Remove item from array
        allItems[section].items.remove(at: fromIndex)
        
        //Insert item in array at new location
        allItems[section].items.insert(movedItem, at: toIndex)
    }
}


