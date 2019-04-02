//
//  Item.swift
//  Todoey
//
//  Created by Adriaan on 2019/04/02.
//  Copyright © 2019 Adriaan. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
