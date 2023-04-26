//
//  MapViewController.swift
//  WordTrotter
//
//  Created by Robert Whitewick on 25/04/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var mapView: MKMapView!
    override func loadView() {
        //Create a map view
        mapView = MKMapView()
        mapView.showsUserLocation = true
        //Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid","Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        
        view.addSubview(segmentedControl)
        
        let segmentedControlTopConstraint = segmentedControl.topAnchor.constraint(equalTo:view.topAnchor,constant: 56)
        let segmentedControlMargins = view.layoutMarginsGuide
        let segmentedControlLeadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlMargins.leadingAnchor)
        let segmentedControlTrailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: segmentedControlMargins.trailingAnchor)
        
        segmentedControlTopConstraint.isActive = true
        segmentedControlLeadingConstraint.isActive = true
        segmentedControlTrailingConstraint.isActive = true
        
        
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.setOn(true, animated: true)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action:#selector(pointsOfInterestToggled(mySwitch:)), for: .valueChanged)
        
        view.addSubview(toggle)

        
        let toggleTopConstraint = toggle.topAnchor.constraint(equalTo:view.topAnchor,constant: 100)
        let toggleMargins = view.layoutMarginsGuide
        let toggleLeadingConstraint = toggle.leadingAnchor.constraint(equalTo: toggleMargins.leadingAnchor)
        toggleTopConstraint.isActive = true
        toggleLeadingConstraint.isActive = true
        
        
        
        let label = UILabel(frame: CGRect(x:0,y:0,width: 200,height: 50))
        label.text = "Points of interest"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        
        view.addSubview(label)
        
        let labelTopConstraint = label.topAnchor.constraint(equalTo: view.topAnchor,constant: 105)
        let labelMargins = view.layoutMarginsGuide
        let labelLeadingConstraint = label.leadingAnchor.constraint(equalTo: labelMargins.leadingAnchor,constant: 55)
        labelTopConstraint.isActive = true
        labelLeadingConstraint.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
    }
                                   
   @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func pointsOfInterestToggled(mySwitch: UISwitch) {
        mapView.showsPointsOfInterest = mySwitch.isOn
    }
}
