//
//  SettingsViewController.swift
//  What's Good?
//
//  Created by Yoshio Fujimoto on 1/17/15.
//  Copyright (c) 2015 Zach Jiroun. All rights reserved.
//

import Foundation
import UIKit
import Realm

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var radiusTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        
        let settings = SettingsData()
        if let radius = radiusTextField.text.toInt()? {
            settings.radius = radius
        }
        
        realm.addObject(settings)
        realm.commitWriteTransaction()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        radiusTextField.resignFirstResponder()
    }
    
}