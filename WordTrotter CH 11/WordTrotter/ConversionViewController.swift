//
//  ViewController.swift
//  WordTrotter
//
//  Created by Robert Whitewick on 24/04/2023.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeperator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeperator = textField.text?.range(of: decimalSeperator)
        let replacementTextHasDecimalSeperator = string.range(of: decimalSeperator)
        
        
        let replacementTextHasAlphaBeticCharacters = string.rangeOfCharacter(from: NSCharacterSet.letters)
        if replacementTextHasAlphaBeticCharacters != nil {
            print("!= nil")
        } else {
            print("== nil")
        }

        if existingTextHasDecimalSeperator != nil,
           replacementTextHasDecimalSeperator != nil {
            if replacementTextHasAlphaBeticCharacters != nil {
                return false
            }
            return false
        } else {
            if replacementTextHasAlphaBeticCharacters != nil {
                return false
            }
            return true
        }
    }
    
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from:NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController")
        updateCelsiusLabel()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField:UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender:UITapGestureRecognizer) {
        textField.resignFirstResponder()
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

