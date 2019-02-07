//
//  DatabaseService.swift
//  Weather
//
//  Created by Евгений Иванов on 16/01/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

import RealmSwift

class DatabaseService {
    
    @discardableResult
    static func save<Element: Object>(_ items: [Element], config: Realm.Configuration = Realm.Configuration.defaultConfiguration, update: Bool = true) throws -> Realm {
        print(config.fileURL ?? "")
        
        let realm = try Realm(configuration: config)
        try realm.write {
            realm.add(items, update: true)
        }
        
        return realm
    }
    
    static func save<Element: Object>(data: [Element], config: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        
        do {
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(data, update: true)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func get<Element: Object>(_ type: Element.Type, config: Realm.Configuration = Realm.Configuration.defaultConfiguration) -> Results<Element>? {
        
        let realm = try? Realm(configuration: config)
        
        return realm?.objects(type)
    }
    
    static func deleteData<Element: Object>(type: Element.Type, config: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        
        do {
            let realm = try Realm(configuration: config)
            let oldData = realm.objects(type)
            realm.beginWrite()
            realm.delete(oldData)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    @discardableResult
    static func deleteMany<T: Object>(_ items: [T], config: Realm.Configuration = Realm.Configuration.defaultConfiguration) throws -> Realm {
        
        let realm = try Realm(configuration: config)
        realm.beginWrite()
        realm.delete(items)
        try realm.commitWrite()
        
        return realm
    }
    @discardableResult
    static func deleteOne<T: Object>(_ item: T, config: Realm.Configuration = Realm.Configuration.defaultConfiguration) throws -> Realm {
        
        let realm = try Realm(configuration: config)
        realm.beginWrite()
        realm.delete(item)
        try realm.commitWrite()
        return realm
    }
}
