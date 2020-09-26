//
//  LocationPickerViewController.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit
import MapKit

protocol LocationPickerDelegate {
    func locationPickerDidAddLocations()
}

class LocationPickerViewController: BaseViewController {
    
    // MARK:- Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK:- Variables
    
    var places = [LocalLocation]()
    var delegate: LocationPickerDelegate?
    let impact = UIImpactFeedbackGenerator()
    
    // MARK:- View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK:- Actions
    
    @IBAction func closeAction(_ sender: UIButton) {
        delegate?.locationPickerDidAddLocations()
        dismissViewController()
    }
    
    // MARK:- Functions
    
    private func initialSetup() {
        setupMapView()
    }
    
    private func setupMapView() {
        let touchGesture = UILongPressGestureRecognizer(target: self, action: #selector(touchedOnMap(gestureRecognizer:)))
        touchGesture.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(touchGesture)
    }
    
    @objc func touchedOnMap(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let coordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            getDetailsFor(coordinates: coordinates)
        }
    }
    
    private func getDetailsFor(coordinates: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { (placemarks, error) in
            if error != nil {
                print("Error adding location")
                return
            }
            if placemarks!.count > 0 {
                self.addAnnotationAtPoint(coordinate: coordinates, placemark: placemarks?.first)
            } else {
                print("Can't fetch location details")
                self.addAnnotationAtPoint(coordinate: coordinates, placemark: placemarks?.first)
            }
        }
    }
    
    private func addAnnotationAtPoint(coordinate: CLLocationCoordinate2D, placemark: CLPlacemark?) {
        impact.impactOccurred()
        var annotationTitle = ""
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        if let placemark = placemark {
            annotationTitle = placemark.locality ?? "N/A"
        } else {
            annotationTitle = "Unknown Place"
        }
        annotation.title = annotationTitle
        mapView.addAnnotation(annotation)
        let placesDict = ["cityName": annotationTitle,
                          "location": coordinate.getLocationString()]
        LocalStorageManager.add(location: placesDict.getLocalLocationModel())
    }
    
}
