//
//  NetworkService.swift
//  Weather
//
//  Created by Евгений Иванов on 24/12/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol VkFetchable: class {
    static var path: String { get }
    static var parameters: Parameters { get }
    static func parseJSON (json: JSON) -> Self
}

class NetworkService {
    
    private let baseUrl = "https://api.vk.com"
    
    func fetch<Element: VkFetchable>(complition: (([Element]?, Error?) -> Void)? = nil) {
        Alamofire.request(baseUrl + Element.path, method: .get, parameters: Element.parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                complition?(nil, error)
            case .success(let value):
                let json = JSON(value)
                let elements: [Element] = json["response"]["items"].arrayValue.map { Element.parseJSON(json: $0) }
                complition?(elements, nil)
            }
        }
    }
    
    public func loadUserFriendsAlamofire(complitionHandler: (([User]?, Error?) -> Void)? = nil) {
        
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "order": "name",
            "fields": "city,photo_id,photo_max_orig",
//            "offset": "5",
//            "count": "3",
            "v": "5.92"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                complitionHandler?(nil, error)
            case .success(let value):
                let json = JSON(value)
                let users = json["response"]["items"].arrayValue.map {
                    User(json: $0)
                }
//                print(users)
                complitionHandler?(users, nil)
            }
        }
    }
    
    public func loadUserPhotosAlamofire(owner_id: Int, complitionHandler: (([PhotoClass]?, Error?) -> Void)? = nil) {
        
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "extended": "1",
            "count": "100",
            "owner_id" : owner_id,
            "v": "5.92",
            "photo_sizes" : "1"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                complitionHandler?(nil, error)
            case .success(let value):
                let json = JSON(value)
                let photo = json["response"]["items"].arrayValue.map { PhotoClass(json: $0) }
                complitionHandler?(photo, nil)
            }
        }
    }
    
    public func loadNotAllUserGroupsAlamofire(complitionHandler: (([Group]?, Error?) -> Void)? = nil) {
        
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "filter": "publics",
            "extended": "1",
//            "count": "3",
            "v": "5.92"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                complitionHandler?(nil, error)
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                complitionHandler?(groups, nil)
            }
        }
    }
    
    public func loadUserGroupsAlamofire(complitionHandler: (([Group]?, Error?) -> Void)? = nil) {
        
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "filter": "publics",
            "extended": "1",
            "v": "5.92"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                complitionHandler?(nil, error)
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                complitionHandler?(groups, nil)
            }
        }
    }
    
    public func searchGroupsAlamofire (searchText: String, complitionHandler: (([Group]?, Error?) -> Void)? = nil) {
        
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "q": searchText,
            "type": "group",
            "v": "5.92"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                complitionHandler?(nil, error)
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                complitionHandler?(groups, nil)
            }
        }
    }
}
