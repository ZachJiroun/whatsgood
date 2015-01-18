//
//  Data.swift
//  What's Good?
//
//  Created by Yoshio Fujimoto on 1/18/15.
//  Copyright (c) 2015 Zach Jiroun. All rights reserved.
//

import Foundation
import Realm

class RealmData: RLMObject {
    dynamic var name = ""
    dynamic var rating = 0.0
    dynamic var distance = 0.0
}