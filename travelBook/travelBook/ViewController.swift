//
//  ViewController.swift
//  travelBook
//
//  Created by kerem on 19.02.2023.
//

import UIKit
import MapKit//bunu import etmeliyiz mapkit in bütün özelliklerine erişebilmek için
import CoreLocation//konum u ekleyip kullanabilmek için.
class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate =  self
        locationManager.delegate = self
        locationManager.desiredAccuracy  = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer: )))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = "New Annotation"
            annotation.subtitle = "Travel Book"
            self.mapView.addAnnotation(annotation)
        }
            
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {//bu kod bize devamlı güncellenen lokasyonları bir dizi içerisinde veriyor.
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span  = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)//bu sayılar ne kadar küçük olursa o kadar zumlamış oluyoruz.
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
}

