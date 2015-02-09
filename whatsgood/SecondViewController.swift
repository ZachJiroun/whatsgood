//
//  SecondViewController.swift
//  whatsgood
//
//  Created by Zach Jiroun on 1/17/15.
//  Copyright (c) 2015 Zach Jiroun. All rights reserved.
//

import UIKit
import CoreLocation

var radiusSetting = 0;

class SecondViewController: UIViewController, CLLocationManagerDelegate {

    var client: YelpClient!
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "VZG9kFo8wT7PhwIfiBGkCg"
    let yelpConsumerSecret = "YW-AeCS_lgpe9mBtm1aKILzQRd8"
    let yelpToken = "61_DImwTxertfarFxxGurhn7YAsJHSsw"
    let yelpTokenSecret = "4MR-xOXoKJXu6jGqDlcrNasvuSA"
    
    @IBOutlet weak var radiusField: UITextField!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithLatLong(term: "Thai", latitude: 38.897946, longitude: -77.021927, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (radiusField.text == "0") {
            showAlertWithText( message: "Please enter a value greater than 1 mile.")
        } else if (radiusField.text != "") {
            println("valid text")
            // Set persistent
            radiusSetting = radiusField.text.toInt()!
        }
        

        
        radiusField.resignFirstResponder()
    }

    func showAlertWithText(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

