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
        
        let strings:[String] = [
            "212",
            "degrees Fahrenheit",
            "is really",
            "100",
            "degrees Celsius"
        ]
        view = UIView()

        class Views {
            var index: Int
            var data: UIView
            var isSpacer: Bool
            init(index: Int, data: UIView, isSpacer: Bool) {
                self.index = index
                self.data = data
                self.isSpacer = isSpacer
            }
        }
        
        var label: UIView!
        var spacer: UIView!
        var spacers: [Views] = [Views]()
        for i in 0..<5{
            var topElement:UIView
            if i == 0 {
                topElement = view
            } else {
                topElement = spacers[spacers.count-1].data
            }
            label = createLabel(topElement:topElement, text:strings[i],index:i)!
            var test1 = Views(index: i, data: label,isSpacer: false)
            if i != 4 {
                spacer = createSpacer(topElement:spacers[spacers.count-1].data,index:i)
                var test1 = Views(index: i, data: spacer,isSpacer: true)
            }
            
        }
        var range = 0..<spacers.count
        for i in range {
            print(i)
            print(spacers[i].index)
            print("---")
            var constraint:NSLayoutConstraint
            var bottomConstraint:NSLayoutConstraint

            if i != 0 {
                let top = spacers[i].data.topAnchor
                let bottom = spacers[i-1].data.bottomAnchor
                if i == 8 {
                    print("hi")
                }
                constraint = top.constraint(equalTo: bottom)
            } else {
                let top = view.topAnchor
                let bottom = spacers[0].data.topAnchor
                constraint = bottom.constraint(equalTo: top,constant: 50)
            }
            if i == 8  {
                let top = spacers[8].data.bottomAnchor
                let bottom = view.bottomAnchor
                bottomConstraint = bottom.constraint(equalTo: top,constant: 100)
                bottomConstraint.isActive = true

            }
            if spacers[i].isSpacer {
                constraint.priority = .defaultHigh
                spacers[i].data.setContentHuggingPriority(.defaultHigh, for: .vertical)
                var height = spacers[i].data.heightAnchor.constraint(equalTo: spacers[1].data.heightAnchor)
                height.isActive = true
            } else {
                constraint.priority = .defaultLow
            }
            constraint.isActive = true
        }
        

        
                
        func  createLabel(topElement:UIView, text:String,index:Int) -> UIView! {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            label.text = text
            label.accessibilityIdentifier = String(index)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            
            let labelCenterConstraint = label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            labelCenterConstraint.isActive = true
            return label
        }
        
        func createSpacer(topElement:UIView, index:Int) -> UIView! {
            let spacer = UIView()
            spacer.translatesAutoresizingMaskIntoConstraints = false
            spacer.accessibilityIdentifier = String(index)
            view.addSubview(spacer)
            
            let spacerWidthConstraint = spacer.widthAnchor.constraint(equalToConstant: 10)
            let spacerCenterConstraint = spacer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            spacerWidthConstraint.priority = .defaultHigh
            spacerCenterConstraint.isActive = true
            spacerWidthConstraint.isActive = true
            return spacer
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

