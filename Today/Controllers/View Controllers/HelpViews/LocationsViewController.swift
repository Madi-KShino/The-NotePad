//
//  LocationsViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/28/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit
import MapKit

class LocationsViewController: UIViewController{

    //Outlets
    @IBOutlet weak var selectLocationButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationListTableView.delegate = self
        locationListTableView.dataSource = self
    }
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension LocationsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
}
