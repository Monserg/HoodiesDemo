//
//  RealmManager.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 16.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager: NSObject {
    // MARK: - Properties
    var realm: Realm!
    
//    var items: Results<Item> {
//        get {
//            return realm.objects(Item.self)
//        }
//    }

    
    // MARK: - Initialization
    override init() {
        super.init()

        self.realm = try! Realm()
    }
    
    
    // MARK: - Custom functions
    func loadItems() -> Results<Item> {
        return realm.objects(Item.self)
    }
    
    func addItem(name: String, complete: @escaping (() -> Void)) {
        let newItem = Item()
        newItem.name = name
        
        try! self.realm.write({
            self.realm.add(newItem)
            
            complete()
        })
    }
    
    func updateItem(oldName: String, newName: String, isChecked: Bool = false, complete: @escaping (() -> Void)) {
        if let updateItem = loadItems().first(where: { $0.name == oldName }) {
            try! realm.write {
                updateItem.name = newName
                updateItem.isChecked = isChecked
                
                complete()
            }
        }
    }
    
    func delete(item: Item) {
        try! realm.write({
            self.realm.delete(item)
        })
    }
}
