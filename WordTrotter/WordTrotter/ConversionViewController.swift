//
//  ViewController.swift
//  WordTrotter
//
//  Created by Robert Whitewick on 24/04/2023.
//

import UIKit

class ConversionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        _ = UIView(frame: CGRect(x: 0,y: 0, width: 320,height: 50))
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.orange.cgColor]
//        gradient.frame = self.view.bounds
//        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var random: UIColor {
            return UIColor(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1.0
            )
        }
        view.backgroundColor = random
    }
    
    
}

