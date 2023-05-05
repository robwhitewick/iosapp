//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Robert Whitewick on 02/05/2023.
//

import UIKit

class DetailViewController:
    UIViewController,
    UITextFieldDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
    {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var deleteView: UIBarButtonItem!
     
    
    @IBAction func deleteImage(_ sender: UIBarButtonItem) {
        print("Deleted")
        ItemsViewController.imageStore.deleteImage(forkey: item.itemKey)
        
        let imageToDisplay = imageStore.image(forKey: item.itemKey)
        imageView.image = imageToDisplay
        
    }
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        print(UIImagePickerController.isSourceTypeAvailable(.camera) )
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera",
                                             style: .default) { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker,animated: true,completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        let photoLibaryAction = UIAlertAction(title: "Photo Libary",
                                              style: .default) { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker,animated: true,completion: nil)
        }
        alertController.addAction(photoLibaryAction)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController,animated: true, completion:nil)
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.setEditing(true, animated: false)
        imagePicker.delegate = self
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Get picked image from info dictionary
        let image = info[.editedImage] as! UIImage
        
        //Store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        //Put that image on the screen in the image view
        imageView.image = image
        
        //Take the image picker off the screen - you must call this dismiss method
        dismiss(animated: true,completion: nil)
    }
    
    
    func setDate(date:String) {
        dateLabel.text = date
    }
    
  
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        //Get the item key
        let key = item.itemKey
        
        //If there is an associated image with the item, display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Clear first responder
        view.endEditing(true)
        
        // "save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
           let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If the triggered segue is "showItem" segue
        switch segue.identifier {
        case "showDate":
            let dateViewController = segue.destination as! DateViewController
            dateViewController.item = item
            dateViewController.date?.setDate(from: dateLabel.text! ,format: "M/D/YYYY")
//            dateLabel = dateViewController.date
            
        default: preconditionFailure("Unexpected segue identifer")
            
        }
    }
}
