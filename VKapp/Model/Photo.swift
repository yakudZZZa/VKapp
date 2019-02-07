//
//  Photo.swift
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
class PhotoClass: Object {
    
    enum Properties: String {
        case ownerId
        case id
        case urlString
        case isLiked
        case likes
    }
    
    dynamic var ownerId: Int = 0
    dynamic var id: Int = 0
    dynamic var urlString: String = ""
    dynamic var isLiked: Int = 0
    dynamic var likes: Int = 0
//    var user = LinkingObjects(fromType: User.self, property: "photos")
    
    convenience init(json: JSON) {
        self.init()
        self.ownerId = json["owner_id"].intValue
        self.id = json["id"].intValue
        self.urlString = json["sizes"][3]["url"].stringValue
        self.isLiked = json["likes"]["user_likes"].intValue
        self.likes = json["likes"]["count"].intValue
    }
    
    override static func primaryKey() -> String? {
        return Properties.id.rawValue
    }
}


