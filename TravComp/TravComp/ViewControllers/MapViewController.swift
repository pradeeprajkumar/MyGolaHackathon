//
//  MapViewController.swift
//  TravComp
//
//  Created by Pradeep Rajkumar on 25/07/15.
//  Copyright (c) 2015 GIB. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    var locationManager = CLLocationManager()
    var currentLocationCoordinate: CLLocationCoordinate2D!
    var destinationCoordinate: CLLocationCoordinate2D!
    var destinationLocationMarker: GMSMarker!
    var destinationLocation: String = ""
    var mapView:GMSMapView!
    var backItemTitle:String?
    let kDestinationCoordinatesFound = "DestinationCoordinatesFound"
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.initializeViewControllerSettings()
    }

    override func loadView() {
        super.loadView()
        
    }
    
    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)

        //store the original title
        backItemTitle = self.navigationController?.navigationBar.topItem?.title
        
        //remove the title for the back button
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func initializeViewControllerSettings () {
        
        self.title = destinationLocation
        self.initializeMapView()
    }
    
    func initializeMapView () {
        
        self.findCoordinatesFromName()

        self.currentLocationCoordinate = locationManager.location.coordinate
        var camera = GMSCameraPosition.cameraWithLatitude(currentLocationCoordinate.latitude,
            longitude: currentLocationCoordinate.longitude, zoom: 9)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView    
    }
    
    func findCoordinatesFromName () {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "destinationCoordinatesFound", name:self.kDestinationCoordinatesFound, object: nil)
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(destinationLocation, completionHandler: { (placemarks:[AnyObject]!, error:NSError!) -> Void in
            if error != nil {
                
                println("Geocode failed with error: \(error.localizedDescription)")
            } else if placemarks.count > 0 {
                
                let placemark = placemarks.last as! CLPlacemark
                let location = placemark.location

                self.destinationCoordinate = CLLocationCoordinate2D()
                self.destinationCoordinate.latitude = location.coordinate.latitude
                self.destinationCoordinate.longitude = location.coordinate.longitude
            NSNotificationCenter.defaultCenter().postNotificationName(self.kDestinationCoordinatesFound, object: nil)

            }
        })
    }
    
    func destinationCoordinatesFound () {
        
        //Found the coordinates
        self.setupDestinationMarker()
    }
    
    func setupDestinationMarker() {
        
        destinationLocationMarker = GMSMarker(position: destinationCoordinate)
        destinationLocationMarker.map = mapView
    }
    
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            
            //restore the orignal title
            navigationController?.navigationBar.backItem?.title = backItemTitle
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}