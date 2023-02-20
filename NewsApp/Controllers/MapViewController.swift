//
//  MapViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit
import MapKit
import SnapKit

final class CustomAnnotation: NSObject, MKAnnotation {
    
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

final class MapViewController: UIViewController {
    
    let mapView = MKMapView()
    let firstPin = CustomAnnotation(coordinate: coordinateFirst, title: "First Pin", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
    let secondPin = CustomAnnotation(coordinate: coordinateSecond, title: "Secon Pin", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
    let thirdPin = CustomAnnotation(coordinate: coordinateThird, title: "Third Pin", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
    let fourthPin = CustomAnnotation(coordinate: coordinateFour, title: "Fourth Pin", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
    let fifthPin = CustomAnnotation(coordinate: coordinateFive, title: "Fifth Pin", subtitle: "Cupertino, CA", image: UIImage(named: "mdi_map-marker"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        configureMap()
        
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureMap() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331820, longitude: -122.031180), latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(firstPin)
        mapView.addAnnotation(secondPin)
        mapView.addAnnotation(thirdPin)
        mapView.addAnnotation(fourthPin)
        mapView.addAnnotation(fifthPin)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
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
