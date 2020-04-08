//
//  SessionHelper.swift
//  Inventory
//
//  Created by Dale Muir on 10/3/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

class SessionHelper: NSObject , URLSessionDataDelegate{
    var session: URLSession!
    
    override init() {
        super.init()
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
}
