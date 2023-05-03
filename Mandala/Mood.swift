//
//  Mood.swift
//  Mandala
//
//  Created by Robert Whitewick on 03/05/2023.
//

import UIKit

struct Mood {
    var name: String
    var image: UIImage
    var colour: UIColor
}

extension Mood {
    static let angry = Mood(name: "angry",
                            image: UIImage(resource: .angry),
                            colour: UIColor.angry)
    
    static let confused = Mood(name: "confused",
                               image: UIImage(resource: .confused),
                               colour: UIColor.confused)
    
    static let crying = Mood(name: "crying",
                             image: UIImage(resource: .crying),
                             colour: UIColor.crying)
    
    static let goofy = Mood(name: "goofy",
                            image: UIImage(resource: .goofy),
                            colour: UIColor.goofy)
    
    static let happy = Mood(name: "happy",
                            image: UIImage(resource: .happy),
                            colour: UIColor.happy)
    
    static let meh = Mood(name: "meh",
                          image: UIImage(resource: .meh),
                          colour: UIColor.meh)
    
    static let sad = Mood(name: "sad",
                          image: UIImage(resource: .sad),
                          colour: UIColor.sad)
    
    static let sleepy = Mood(name: "sleepy",
                             image: UIImage(resource: .sleepy),
                             colour: .sleepy)
}
