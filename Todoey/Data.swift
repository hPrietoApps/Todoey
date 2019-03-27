//
//  Data.swift
//  Todoey
//
//  Created by Heber Prieto on 3/19/19.
//  Copyright © 2019 Heber Prieto. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
