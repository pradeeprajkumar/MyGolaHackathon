//
//  MapsManager.swift
//  TravComp
//
//  Created by Pradeep Rajkumar on 25/07/15.
//  Copyright (c) 2015 GIB. All rights reserved.
//

import UIKit

class MapsManager: NSObject {

    //Class Variables
    var locationManager = CLLocationManager()

    
    class var sharedInstance: MapsManager {
        struct Static {
            static let instance: MapsManager = MapsManager()
        }
        return Static.instance
    }
  
}
