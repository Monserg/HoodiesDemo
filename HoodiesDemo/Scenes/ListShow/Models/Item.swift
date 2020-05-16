//
//  Item.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit
import RealmSwift

class Item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var isChecked = false
}
