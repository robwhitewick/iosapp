//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by Robert Whitewick on 05/05/2023.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var photoDescription: String?
    
    @IBOutlet var label: UILabel!
    
    func update(displaying image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return super.accessibilityTraits.union([.image, .button])
        }
        set {
            //Ignore attempts to set
        }
    }
    
    
    override var accessibilityLabel: String? {
        get {
            return photoDescription
        }
        set {
            //Ignore attempts to set
        }
    }
    
    override var isAccessibilityElement: Bool {
        get {
            return true
        }
        set {
            //Ignore attempts to set
        }
    }
    
}


