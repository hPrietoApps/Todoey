//
//  Category.swift
//  Todoey
//
//  Created by Heber Prieto on 3/21/19.
//  Copyright © 2019 Heber Prieto. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
