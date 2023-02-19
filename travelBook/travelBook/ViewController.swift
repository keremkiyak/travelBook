//
//  ViewController.swift
//  travelBook
//
//  Created by kerem on 19.02.2023.
//

import UIKit
import MapKit//bunu import etmeliyiz mapkit in bütün özelliklerine erişebilmek için
class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate =  self
    }


}

