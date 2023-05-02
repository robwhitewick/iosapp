//
//  ViewController.swift
//  Buggy
//
//  Created by Robert Whitewick on 27/04/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func buttonTapped(_ sender:UIButton) {
        print("called buttonTapped(_:)")
        
        badMethod()
    }
    func badMethod() {
        let array = NSMutableArray()
        
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        for _ in 0..<10 {
            array.removeObject(at: 0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

