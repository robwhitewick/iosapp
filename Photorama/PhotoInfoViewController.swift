//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Robert Whitewick on 05/05/2023.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
                self.photo.viewCount = self.photo.viewCount + 1
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTags":
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            
            tagController.store = store
            tagController.photo = photo
            
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
