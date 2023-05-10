//
//  ViewController.swift
//  Photorama
//
//  Created by Robert Whitewick on 04/05/2023.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    var store: PhotoStore!
    
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.accessibilityLabel = "Photo rama"
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        updateDataSource()
        
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            
            self.updateDataSource()
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        //Download the image data, which could take some time
        store.fetchImage(for: photo) { (result) -> Void in
            //The index path for the photo might have changed between the
            //time the request started and finished, so find the most
            // recent index path
            
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                  case let .success(image) = result else {
                return
            }
            
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            //When the reuqest finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                as? PhotoCollectionViewCell {
                cell.update(displaying: image)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto":
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func toggleFavoriteView(_ sender: UISegmentedControl) {
        
        photoDataSource.photos.removeAll()
        switch sender.selectedSegmentIndex {
        case 0:
            updateDataSource(favorite: false)
        case 1:
            updateDataSource(favorite: true)
        default:
            updateDataSource(favorite: false)
        }
    }
    
    func updateDataSource(favorite: Bool = false) {
        store.fetchAllPhotos(favorite: favorite) {
            (photosResult) in
            
            switch photosResult {
            case let .success(photos):
                self.photoDataSource.photos = photos
            case .failure:
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    
    @IBAction func onSegmentedChange(_ sender: UISegmentedControl) {
        self.photoDataSource.photos.removeAll()
        
        self.updateDataSource(favorite: true)
    }

    

}

