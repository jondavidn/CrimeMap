//
//  DataPoints.swift
//  CrimeMap
//
//  Created by Jim on 6/4/16.
//  Copyright © 2016 Jonathan Niemerg. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class DataPoints: NSObject,MKAnnotation{
    
  
    let title:String?
    let locationName:String!
    let district:String!
    let coordinate:CLLocationCoordinate2D
    
    init(title:String,locationName:String,district:String,coordinate:CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.district = district
        self.coordinate = coordinate
        super.init()
    }
   
    class func fromDataArray(dataDictionary:NSDictionary!)->DataPoints?{

        var latitude:Double = 0.0
        var longitude:Double = 0.0
        
        let date:String! = dataDictionary["occurred_on_date"] as! String
        let time:String! = dataDictionary["occurred_on_time"] as! String
        
        
        
        let location:NSDictionary! = dataDictionary.objectForKey("geom") as! NSDictionary!
        if location != nil{
            let type:String! = location.objectForKey("type") as! String!
            if type == "Point"
            {
                let coordinates:NSArray! = location.objectForKey("coordinates") as! NSArray
                latitude = Double(coordinates[1] as! NSNumber)
                longitude = Double(coordinates[0] as! NSNumber)
            }
            
        }
        
        let pddDistrict = dataDictionary["offense_description"] as! String
        
        let titleForPoint:String! = "\(date):\(time)"
        let subtitleForPoint:String! = "\("crime"):\(pddDistrict)"
        let location2d:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        
        return DataPoints.init(title: titleForPoint, locationName: subtitleForPoint, district: pddDistrict, coordinate: location2d)
    }
    var subtitle:String?{
        return locationName
    }
    
}