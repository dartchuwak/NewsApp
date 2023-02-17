//
//  MapViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, image: UIImage?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

class MapViewController: UIViewController {
    
    let mapView = MKMapView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
     
        
        let firstPin = CustomAnnotation(coordinate: coordinateFirst, title: "One", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
        let secondPin = CustomAnnotation(coordinate: coordinateSecond, title: "Two Park", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
        let thirdPin = CustomAnnotation(coordinate: coordinateThird, title: "Three Park", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
        let fourPin = CustomAnnotation(coordinate: coordinateFour, title: "Four Park", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331820, longitude: -122.031180), latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(firstPin)
        mapView.addAnnotation(secondPin)
        mapView.addAnnotation(thirdPin)
        mapView.addAnnotation(fourPin)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
       
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ] )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomAnnotation else { return nil }

        let identifier = "customAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        annotationView?.image = annotation.image

        return annotationView
    }

    
}
