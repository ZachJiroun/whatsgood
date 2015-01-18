//
//  PlanViewController.swift
//  What's Good?
//
//  Created by Zach Jiroun on 1/18/15.
//  Copyright (c) 2015 Zach Jiroun. All rights reserved.
//

import Foundation
import UIKit
import Realm
import CoreLocation



class PlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var array = RealmData.allObjectsInRealm(RLMRealm(path: "itinerary.realm"))
    var planNames: [String] = []
    var planRatings: [Double] = []
    var planDistances: [Double] = []
    
    var notificationToken: RLMNotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initiate plan

        // Clear the tempPlan
        
        planNames.removeAll(keepCapacity: false)
        planRatings.removeAll(keepCapacity: false)
        planDistances.removeAll(keepCapacity: false)
        
        let itineraryRealm = RLMRealm(path: "itinerary.realm")
        // RLMRealm.migrateRealmAtPath(itineraryRealm.path)
        
        let item = RealmData()
        item.name = "Chicken"
        item.rating = 3
        item.distance = 2.3
        
        itineraryRealm.beginWriteTransaction()
        itineraryRealm.addObject(item)
        itineraryRealm.commitWriteTransaction()

        
        for planItem in RealmData.allObjectsInRealm(itineraryRealm) {
            planNames.append((planItem as RealmData).name as String)
            planRatings.append((planItem as RealmData).rating)
            planDistances.append((planItem as RealmData).distance)
        }
        
        
        
        
//        for obj in RealmData.allObjects() {
//            println("item")
//            println((obj as RealmData).name)
//        }
        

//        notificationToken = RLMRealm.defaultRealm().addNotificationBlock {
//            note, realm in self.tableView.reloadData()
//        }

        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(array.count)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println(indexPath.row)
        let itineraryRealm = RLMRealm(path: "itinerary.realm")

        
        PlanViewController().planNames.removeAll(keepCapacity: false)
        PlanViewController().planRatings.removeAll(keepCapacity: false)
        PlanViewController().planDistances.removeAll(keepCapacity: false)
        
        for planItem in RealmData.allObjectsInRealm(itineraryRealm) {
            PlanViewController().planNames.append((planItem as RealmData).name)
            PlanViewController().planRatings.append((planItem as RealmData).rating)
            PlanViewController().planDistances.append((planItem as RealmData).distance)
        }
        
        var cell: ItineraryCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as ItineraryCell
        
        cell.nameField.text = planNames[indexPath.row]
        
        cell.ratingField.text = planRatings[indexPath.row].description
        
        cell.distanceField.text = planDistances[indexPath.row].description
        
        
        return cell
    }
    
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        var receiver = ItineraryViewController()
        receiver.substituteIdx = indexPath.row // Set parameter
        println("Substitute idx = \(receiver.substituteIdx)")
        self.performSegueWithIdentifier("showOptions", sender: self)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var uberAction = UITableViewRowAction(style: .Normal, title: "Uber") { (action, indexPath) -> Void in
            tableView.editing = false
            println("uber")
        }
        uberAction.backgroundColor = UIColor(red: 40.0/255.0, green: 229.0/255.0, blue: 253.0/255.0, alpha: 1)
        
        var mapAction = UITableViewRowAction(style: .Default, title: "Directions") { (action, indexPath) -> Void in
            tableView.editing = false
            println("directions")
        }
        mapAction.backgroundColor = UIColor(red: 50.0/255.0, green: 232.0/255.0, blue: 183.0/255.0, alpha: 1)
        
        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) -> Void in
            tableView.editing = false
            println("deleted")
            
            let itineraryRealm = RLMRealm(path: "itinerary.realm")
            
            itineraryRealm.beginWriteTransaction()
            itineraryRealm.deleteObject(self.array[UInt(indexPath.row)] as RLMObject)
            itineraryRealm.commitWriteTransaction()
            
            PlanViewController().planNames.removeAll(keepCapacity: false)
            PlanViewController().planRatings.removeAll(keepCapacity: false)
            PlanViewController().planDistances.removeAll(keepCapacity: false)
            
            for planItem in RealmData.allObjectsInRealm(itineraryRealm) {
                PlanViewController().planNames.append((planItem as RealmData).name as String)
                PlanViewController().planRatings.append((planItem as RealmData).rating)
                PlanViewController().planDistances.append((planItem as RealmData).distance)
            }

            tableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor(red: 253.0/255.0, green: 112.0/255.0, blue: 74.0/255.0, alpha: 1)
        
        return [deleteAction, mapAction, uberAction]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Needs to be here for the delete button to work
    }
    
}