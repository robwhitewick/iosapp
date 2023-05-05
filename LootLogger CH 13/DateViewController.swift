//
//  dateViewController.swift
//  LootLogger
//
//  Created by Robert Whitewick on 02/05/2023.
//

import UIKit

class DateViewController: UIViewController{
    @IBOutlet var date: UIDatePicker?
    
    var item: Item!
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Clear first responder
        view.endEditing(true)
        
        item.dateCreated = date!.date
        
    }
    
}



extension UIDatePicker {

   func setDate(from string: String, format: String, animated: Bool = true) {

      let formater = DateFormatter()

      formater.dateFormat = format

      let date = formater.date(from: string) ?? Date()

      setDate(date, animated: animated)
   }
}
