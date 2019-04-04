//
//  Category.swift
//  Todoey
//
//  Created by Adriaan on 2019/04/02.
//  Copyright © 2019 Adriaan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
