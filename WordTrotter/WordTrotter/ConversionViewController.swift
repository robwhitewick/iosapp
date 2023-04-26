//
//  ViewController.swift
//  WordTrotter
//
//  Created by Robert Whitewick on 24/04/2023.
//

import UIKit

class ConversionViewController: UIViewController {
    override func loadView() {
        super.loadView()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.text = "100"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
        
        func createSpacer() {
            let spacer = UIView()
            let spacerWidthConstraint = spacer.widthAnchor.constraint(equalToConstant: 10)
            spacerWidthConstraint.priority = .defaultLow
            spacerWidthConstraint.isActive = true
            
            view.addSubview(spacer)
        }
        
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

