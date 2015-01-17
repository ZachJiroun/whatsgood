//
//  ItineraryViewController.swift
//  
//
//  Created by Zach Jiroun on 1/17/15.
//
//

import Foundation
import UIKit
import CoreLocation

var attractions: [String] = []
var food: [String] = []
var events: [String] = []

class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var refreshControl:UIRefreshControl!  // An optional variable
    
    @IBOutlet weak var cityNav: UINavigationItem!
    
    @IBOutlet weak var itinerary: UITableView!
    
    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 38.9380912, longitude: -77.0449327) // Default location
    var currCity: String = "Location unavailable"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        itinerary?.addSubview(refreshControl)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return attractions.count
        case 1:
            return food.count
        case 2:
            return events.count
        default:
            return 0
        }
    }
    
    func refresh(sender: AnyObject) { // Pro version will check in background then push. Free is manual..
        
        println("Refresh worked!")
        self.refreshControl.endRefreshing() // End refreshing
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        
        if (indexPath.section == 0) { // Attractions
            if (attractions.count == 0) { // Create empty cell
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            } else {
                if (indexPath.row < attractions.count) {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
                    cell.textLabel.text = attractions[indexPath.row]
                }
            }
        } else if (indexPath.section == 1) { // Food
            if (food.count == 0) { // Create empty cell
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            } else {
                if (indexPath.row < food.count) {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
                    cell.textLabel.text = food[indexPath.row]
                }
            }
        } else if (indexPath.section == 2) { // Events
            if (events.count == 0) { // Create empty cell
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            } else {
                if (indexPath.row < events.count) {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
                    cell.textLabel.text = events[indexPath.row]
                }
            }
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Attractions"
        case 1:
            return "Food"
        case 2:
            return "Events"
        default:
            return ""
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation: CLLocation = locations[0] as CLLocation
        location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(locationManager.location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Error in getting city")
            }
            
            if (placemarks.count > 0) {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Error with data")
            }
        })
        
        // Google Places
        
        
        
        
        var gp = GooglePlaces()
        
        gp.search(location, radius: 20000, query: "museum") { (items, errorDescription) -> Void in // Radius in meters
            
            println("Result count: \(items!.count)")
            
            for index in 0..<items!.count {
                
                attractions.append(items![index].name)
                // println(attractions)
            }
            
            self.itinerary.reloadData()
            
        }
        
        gp.search(location, radius: 20000, query: "food") { (items, errorDescription) -> Void in // Radius in meters
            
            println("Result count: \(items!.count)")
            
            for index in 0..<items!.count {
                
                food.append(items![index].name)
                // println(food)
            }
            
            self.itinerary.reloadData()
        }
        
        gp.search(location, radius: 20000, query: "night_club") { (items, errorDescription) -> Void in // Radius in meters
            
            println("Result count: \(items!.count)")
            
            for index in 0..<items!.count {
                
                events.append(items![index].name)
                // println(events)
            }
            
            self.itinerary.reloadData()
        }

    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        println(placemark.locality)
        currCity = placemark.locality
        println("city: \(currCity)")
        println(placemark.postalCode)
        
        // Format navigation bar
        println("current city \(currCity)")
        cityNav.title = currCity
    }
    
    
}
