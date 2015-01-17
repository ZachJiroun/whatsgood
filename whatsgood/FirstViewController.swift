//
//  FirstViewController.swift
//  whatsgood
//
//  Created by Zach Jiroun on 1/17/15.
//  Copyright (c) 2015 Zach Jiroun. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    var client: YelpClient!
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "VZG9kFo8wT7PhwIfiBGkCg"
    let yelpConsumerSecret = "YW-AeCS_lgpe9mBtm1aKILzQRd8"
    let yelpToken = "61_DImwTxertfarFxxGurhn7YAsJHSsw"
    let yelpTokenSecret = "4MR-xOXoKJXu6jGqDlcrNasvuSA"
    
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


}

