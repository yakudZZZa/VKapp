//
//  user.swift
//  Weather
//
//  Created by Евгений Иванов on 24/12/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import Alamofire

@objcMembers
class User: Object {
    
    enum Properties: String {
        case id
        case name
        case avatarStringURL
    }
    
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var avatarStringURL: String = ""
//    var photos = List<PhotoClass>()

    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.avatarStringURL = json["photo_max_orig"].stringValue
        self.name = json["first_name"].stringValue + " " + json["last_name"].stringValue
//        self.photos.append(objectsIn: photos)
    }
    
    override static func primaryKey() -> String? {
        return Properties.id.rawValue
    }
}

extension User {
    static func == (lhs: User, rhs: User) -> Bool {
        return
            lhs.name == rhs.name
    }
}
