//
//  Group.swift
//  Weather
//
//  Created by Евгений Иванов on 25/12/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import Alamofire

@objcMembers
class Group: Object {
    
    enum Properties: String {
        case id
        case name
        case photoUrlString
    }
    
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var photoUrlString: String = ""
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photoUrlString = json["photo_50"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return Properties.id.rawValue
    }
}

extension Group {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
}
