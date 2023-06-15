//
//  ViewController.swift
//  Project16
//
//  Created by BTSL.SAJID on 15/6/23.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.5072222, longitude: -0.1275), info: "Home of 2012 Summer Olympics", WikipediaURLString: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", WikipediaURLString: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", WikipediaURLString: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", WikipediaURLString: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", WikipediaURLString: "https://en.wikipedia.org/wiki/Washington_(state)")
        
        //        mapView.addAnnotation(london)
        //        mapView.addAnnotation(oslo)
        //        mapView.addAnnotation(paris)
        //        mapView.addAnnotation(rome)
        //        mapView.addAnnotation(washington)
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeMapType))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Capital")
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        //        annotationView?.tintColor = .green
        annotationView?.markerTintColor = .green
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Wikipedia", style: .default) { _ in
            self.showWebView(url: capital.WikipediaURLString)
        })
        present(ac, animated: true)
    }
    
    func showWebView(url: String) {
        guard let detailWebVC = storyboard?.instantiateViewController(identifier: "Detail") as? DetailWebView else { return }
        
        detailWebVC.url = url
        navigationController?.pushViewController(detailWebVC, animated: true)    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Pick MapType", message: nil, preferredStyle: .actionSheet)
        let satellite = UIAlertAction(title: "Satellite", style: .default){ _ in
            self.mapView.mapType = .satellite
        }
        let standard = UIAlertAction(title: "Standard", style: .default){ _ in
            self.mapView.mapType = .standard
        }
        let hybrid = UIAlertAction(title: "Hybrid", style: .default){ _ in
            self.mapView.mapType = .hybrid
        }
        let mutatedStandard = UIAlertAction(title: "Mutated Standard", style: .default){ _ in
            self.mapView.mapType = .mutedStandard
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(satellite)
        ac.addAction(standard)
        ac.addAction(hybrid)
        ac.addAction(mutatedStandard)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
}

