//
//  Session.swift
//  Weather
//
//  Created by Евгений Иванов on 18/12/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

class Session {
    
    private init() {}
    
    public static let shared = Session()
    
    var token = ""
    var userId = 0
    
}
