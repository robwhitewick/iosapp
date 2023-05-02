//
//  Item.swift
//  LootLogger
//
//  Created by Robert Whitewick on 27/04/2023.
//

import UIKit

class Item: Equatable {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    let section:Int
    let placeHolder:Bool
    
    init(name: String, serialNumber: String?, valueInDollars: Int, section: Int, placeHolder: Bool) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.section = section
        self.placeHolder = placeHolder
    }
    convenience init(sectionArg:Int = 0,random: Bool = false,placeholder:Bool = false) {
        if !placeholder {
            if random {
                let adjectives = ["Fluffy", "Rusty", "Shiny"]
                let nouns = ["Bear", "Spork", "Mac"]
                
                let randomAdjective = adjectives.randomElement()!
                let randomNoun = nouns.randomElement()!
                
                let randomName = "\(randomAdjective) \(randomNoun)"
                let randomValue = Int.random(in: 0..<100)
                let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
                var section: Int
                
                if randomValue > 50 {
                    section = 0
                } else {
                    section = 1
                }
                
                self.init(name: randomName,
                          serialNumber: randomSerialNumber,
                          valueInDollars: randomValue, section: section,
                          placeHolder: placeholder)
            } else {
                self.init(name:"",serialNumber:nil,valueInDollars:0,section: 1, placeHolder: placeholder)
            }
        } else {
            self.init(name:"",serialNumber:nil,valueInDollars:0,section: sectionArg,placeHolder: true)
        }
    }
    
    static func == (lhs: Item, rhs:Item) -> Bool {
    
        return lhs.name == rhs.name && lhs.serialNumber == rhs.serialNumber && lhs.valueInDollars == rhs.valueInDollars && lhs.dateCreated == rhs.dateCreated && lhs.section == rhs.section
    }
}
